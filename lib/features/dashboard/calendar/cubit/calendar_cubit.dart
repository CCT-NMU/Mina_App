import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/services/auth_service/platform/supabase_auth_service.dart';
import 'package:mina_app/services/prediction_service.dart';

part 'calendar_state.dart';

//Cubit to manage calendar state and data loading
class CalendarCubit extends Cubit<CalendarState> {
  final DayEntryRepository dayEntryRepository;
  final String userId = SupabaseAuthService().currentUser!.id;
  final PredictionService predictionService = PredictionService(
      cycleRepository: CycleRepository()); //ToDo:remove drift database capacity
  final Map<String, List<Day>> _cachedDays = {}; // Cache for loaded days
  final Map<String, Cycle> _predictedCycles = {}; // Cache for predicted days
  final int _thresholdFactor =
      5; // Dynamic threshold factor (e.g., 20% of cache size)

  CalendarCubit({required this.dayEntryRepository}) : super(CalendarInitial());
//ToDo: set up calculation for predicted months using PredictionService avgCycleLength and avgPeriodLength for handleScroll
//ToDo: emit the predicted months in CalendarLoaded state
  void loadInitialCalendar(DateTime initialFocusedDay) async {
    emit(CalendarLoading()); // Optional: Emit a loading state if needed

    try {
      final cycleStats = await predictionService.getPredictionStats(userId);

      //if app calendar must show predicted cycles it needs to know where to start from
      //the last recorded cycle can be either a completed cycle or an ongoing one
      //to simplify we take the start date of the last recorded cycle regardless of whether it's completed or ongoing
      //UI will be responsible for displaying predicted days that are part of ongoing cycle.

      //retrieve last recorded cycle
      final lastCycle = await CycleRepository()
          .findLatestRecordedCycle(SupabaseAuthService().currentUser!.id);
      if (lastCycle != null) {
        var startDate = lastCycle.startDate!;
        //Use start date of last recorded cycle to base predictions on
        for (int i = 0; i < 6; i++) {
          var predictedCycleStart = startDate
              .add(Duration(days: cycleStats['averageCycleLength'] * (i + 1)));
          var predictedCycle = Cycle(
              userId: userId,
              startDate: predictedCycleStart,
              endDate: predictedCycleStart
                  .add(Duration(days: cycleStats['averageCycleLength'] - 1)),
              periodEndDate: predictedCycleStart
                  .add(Duration(days: cycleStats['averagePeriodLength'] - 1)));
          var key =
              '${predictedCycle.startDate!.toIso8601String().substring(0, 10)} - ${predictedCycle.endDate!.toIso8601String().substring(0, 10)}';
          _predictedCycles[key] = predictedCycle;
        }
      }
      final days = await _loadEventsFromDatabase(initialFocusedDay);
      if (days != null) {
        final String monthKey =
            '${initialFocusedDay.year}-${initialFocusedDay.month}';
        _cachedDays[monthKey] = days;
        //Calculate the next 6 months of predicted cycles based on average cycle length
        if (cycleStats['averageCycleLength'] > 0) {}
        emit(CalendarLoaded(
            cachedmonths: _cachedDays,
            predictedMonths:
                _predictedCycles)); // Emit the CalendarLoaded state
        print(state);
      } else {
        emit(CalendarLoaded(
            cachedmonths: {}, predictedMonths: _predictedCycles));
      }
    } catch (e) {
      emit(CalendarError(message: 'Failed to load initial calendar: $e'));
    }
  }

  void selectDay(DateTime selectedDay) {
    emit(CalendarDaySelected(selectedDay: selectedDay));
  }

//handle scroll events to load more months dynamically using a threshold
  Future<void> handleScroll(DateTime focusedDay) async {
    final List<String> sortedKeys = _cachedDays.keys.toList()..sort();
    final String firstKey = sortedKeys.first;
    final String lastKey = sortedKeys.last;

    final DateTime firstCachedMonth = DateTime.parse('$firstKey-01');
    final DateTime lastCachedMonth = DateTime.parse('$lastKey-01');

    // Calculate dynamic threshold
    final int cacheSize = _cachedDays.length;
    final int threshold = (cacheSize / _thresholdFactor).ceil();

    if (focusedDay
        .isBefore(firstCachedMonth.subtract(Duration(days: threshold * 30)))) {
      // Fetch earlier months (tail)
      await _fetchMoreMonths(tail: true, referenceMonth: firstCachedMonth);
    } else if (focusedDay
        .isAfter(lastCachedMonth.add(Duration(days: threshold * 30)))) {
      // Fetch later months (head)
      await _fetchMoreMonths(tail: false, referenceMonth: lastCachedMonth);
    }
    emit(CalendarLoaded(cachedmonths: _cachedDays, predictedMonths: {}));
    print(state);
  }

  Future<void> _fetchMoreMonths(
      {required bool tail, required DateTime referenceMonth}) async {
    final DateTime targetMonth = tail
        ? DateTime(referenceMonth.year, referenceMonth.month - 1, 1)
        : DateTime(referenceMonth.year, referenceMonth.month + 1, 1);

    final days = await _loadEventsFromDatabase(targetMonth);
    if (days != null) {
      final String monthKey = targetMonth.toIso8601String().substring(0, 7);
      _cachedDays[monthKey] = days;
    }
  }

  Future<List<Day>?> _loadEventsFromDatabase(DateTime focusedDay) async {
    try {
      print('Loading events for month: ${focusedDay.month}');
      final DateTime firstDayOfMonth =
          DateTime(focusedDay.year, focusedDay.month, 1);
      final DateTime lastDayOfMonth =
          DateTime(focusedDay.year, focusedDay.month + 1, 0);

      return await dayEntryRepository.getDaysInRange(
          firstDayOfMonth, lastDayOfMonth);
    } catch (e) {
      print('Error loading events: $e');
      return null;
    }
  }

  void updateDatabaseChanges(DateTime affectedMonth, List<Day> updatedDays) {
    final String monthKey = '${affectedMonth.year}-${affectedMonth.month}';
    _cachedDays[monthKey] = updatedDays;
  }
}
