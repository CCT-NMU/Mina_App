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
  final Map<String, List<Day>> _cachedDays = {}; // Cache for loaded days
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
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    {
      try {
        print(
            'Loading dashboard in dashboardBloc for date: ${event.focusedDay}');
        final stats = 1; //await _predictionService.getPredictionStats(userId);
        final nextPeriod = PeriodDay(
            date: DateTime.now(),
            flowWeight: FlowWeight.heavy,
            isPeriodStartDay: true,
            isPeriodEndDay:
                true); // await _predictionService.predictNextPeriod(userId);
        final cycles = 1; //await cycleRepository.calculateCycleHistory(userId);
        // Schedule notification if enabled
        /*   final settings = await userRepository.getAllSettings(userId);
        final enableReminders = settings['enable_period_reminders'] == 'true';
        final reminderDays = int.parse(settings['reminder_days'] ?? '2');
 */ /* 
        if (enableReminders && nextPeriod != null) {
          await _notificationService.schedulePeriodReminder(nextPeriod, userId);
        } */

        /*  if (stats is) {
          emit(DashboardLoadSuccess(
              averageCycleLength: -1,
              averagePeriodLength: -1,
              cycleRegularity: -1,
              recentCycles: [],
              ));
        } else { */
        emit(DashboardLoadSuccess(
            nextPeriodDate: nextPeriod.date,
            averageCycleLength: 1, //stats['averageCycleLength'] as int,
            averagePeriodLength: 1, //stats['averagePeriodLength'] as int,
            cycleRegularity: 1, //stats['cycleRegularity'] as double,
            recentCycles: <Cycle>[] // cycles,
            ));
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
