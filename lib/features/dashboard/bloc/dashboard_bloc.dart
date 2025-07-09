import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/model/model.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/data/repositories/user_repository.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_events.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_states.dart';
import 'package:mina_app/services/auth_service/platform/supabase_auth_service.dart';
import 'package:mina_app/services/prediction_service.dart';
import 'package:mina_app/services/notification_service.dart';
import 'package:mina_app/data/database/databaseHelper.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final PredictionService _predictionService;
  final NotificationService _notificationService;
  final DayEntryRepository dayEntryRepository;
  final CycleRepository cycleRepository;
  final UserRepository userRepository;
  final String userId = SupabaseAuthService().currentUserId!;
  final AppDatabase dbHelper;

  DashboardBloc({
    PredictionService? predictionService,
    NotificationService? notificationService,
    required this.cycleRepository,
    required this.dayEntryRepository,
    required this.userRepository,
    required this.dbHelper,
  })  : _predictionService = predictionService ??
            PredictionService(cycleRepository: cycleRepository),
        _notificationService = notificationService ?? NotificationService(),
        super(DashboardInitial()) {
    on<LoadDashboard>((event, emit) async {
      emit(DashboardLoadInProgress());

      await _onLoadDashboard(event, emit);
    });
    // on<RefreshDashboard>(_onRefreshDashboard);

    on<UpdateDayEntry>((event, emit) async {
      add(LoadDashboard(event.day));
    });

    on<DeletePeriodDay>((event, emit) async {
      add(LoadDashboard(event.day));
    });

    on<DeleteDay>((event, emit) async {
      add(LoadDashboard(event.day));
    });

    on<CalendarChanged>((event, emit) async {
      //call Database and retrieve new set of days for 1 month forward and 1 month back
      add(LoadDashboard(event.day));
    });
  }

  Future<List<Day>?> _loadEventsFromDatabase(DateTime _focusedDay) async {
    try {
      print('Loading events for month: ${_focusedDay.month}');
      // Get the current 3 month's range
      int previousMonth = _focusedDay.month - 1;
      int previousMonthYear = _focusedDay.year;
      if (previousMonth < 1) {
        previousMonth = 12;
        previousMonthYear -= 1;
      }
      final DateTime firstDayOfPrevMonth = DateTime(
        previousMonthYear,
        previousMonth,
        1,
      );

      // Calculate the last day of the month after the focused month
      int nextMonth = _focusedDay.month + 1;
      int nextMonthYear = _focusedDay.year;
      if (nextMonth > 12) {
        nextMonth = 1;
        nextMonthYear += 1;
      }
      final DateTime lastDayOfNextMonth = DateTime(
        nextMonthYear,
        nextMonth + 1,
        0,
      );

      // Fetch days from repository
      return await dayEntryRepository.getDaysInRange(
          firstDayOfPrevMonth, lastDayOfNextMonth);

      // Update state with new events
    } catch (e) {
      print('Error loading events: $e');
      // Optionally show an error message to the user
      /* if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load period days'),
            backgroundColor: Colors.red,
          ),
        );
      } */
    }
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    {
      try {
        print(
            'Loading dashboard in dashboardBloc for date: ${event.focusedDay}');
        final stats = await _predictionService.getPredictionStats(userId);
        final nextPeriod = await _predictionService.predictNextPeriod(userId);
        final cycles = await cycleRepository.calculateCycleHistory(userId);
        final days = await _loadEventsFromDatabase(event.focusedDay);
        // Schedule notification if enabled
        /*   final settings = await userRepository.getAllSettings(userId);
        final enableReminders = settings['enable_period_reminders'] == 'true';
        final reminderDays = int.parse(settings['reminder_days'] ?? '2');
 */ /* 
        if (enableReminders && nextPeriod != null) {
          await _notificationService.schedulePeriodReminder(nextPeriod, userId);
        } */

        if (days == null) {
          emit(DashboardLoadSuccess(
              averageCycleLength: -1,
              averagePeriodLength: -1,
              cycleRegularity: -1,
              recentCycles: [],
              days: []));
        } else {
          emit(DashboardLoadSuccess(
            nextPeriodDate: nextPeriod,
            averageCycleLength: stats['averageCycleLength'] as int,
            averagePeriodLength: stats['averagePeriodLength'] as int,
            cycleRegularity: stats['cycleRegularity'] as double,
            recentCycles: cycles,
            days: days,
          ));
        }
      } catch (e) {
        emit(DashboardLoadFailure(e.toString()));
      }
    }

    Future<void> _onRefreshDashboard(
      RefreshDashboard event,
      Emitter<DashboardState> emit,
    ) async {
      await _onLoadDashboard(LoadDashboard(event.focusedDay), emit);
    }
  }
}
