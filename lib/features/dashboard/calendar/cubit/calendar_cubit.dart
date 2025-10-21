import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
  final PredictionService
      predictionService; //ToDo:remove drift database capacity
  final Map<String, List<Day>> _cachedDays = {}; // Cache for loaded days
  final Map<String, Cycle> _predictedCycles = {}; // Cache for predicted days
  final int _thresholdFactor =
      5; // Dynamic threshold factor (e.g., 20% of cache size)

  CalendarCubit(
      {required this.dayEntryRepository, required this.predictionService})
      : super(CalendarInitial());

//ToDo: emit the predicted months in handleScroll event
//ToDo: calculate predicted cycles based on average cycle length and period length

  void loadInitialCalendar(DateTime initialFocusedDay) async {
    emit(CalendarLoading());
    try {
      //calculate predicted cycles
      populateCyclePredictionCache(initialFocusedDay, false);

      final days = await _loadEventsFromDatabase(initialFocusedDay);
      if (days != null) {
        final String monthKey =
            '${initialFocusedDay.year}-${initialFocusedDay.month}';
        _cachedDays[monthKey] = days;
        emit(CalendarLoaded(
            cachedmonths: _cachedDays,
            predictedCycles:
                _predictedCycles)); // Emit the CalendarLoaded state
        print(state);
      } else {
        emit(CalendarLoaded(
            cachedmonths: {}, predictedCycles: _predictedCycles));
      }
    } catch (e) {
      emit(CalendarError(message: 'Failed to load initial calendar: $e'));
    }
  }

//Prediction engine.
//Dynamically updates the _predictedCycles map with cycles
//based on the length of a cycle and the position of the calendar view
//['focusedDay']
  void populateCyclePredictionCache(DateTime focusedDay, bool tail) async {
    // things that need to happen here:
    //1- maintain a prediction range of 24 months worth of predicted cycles
    //   12 in the past and 12 in the future from the last recorded cycle
    //2- store predicted cycles in _predictedCycles map
    //3- initial calcualtions calendar load should calculate at least 12 months ahead
    //4- subsequent scroll events should calculate more months dynamically based on 6 month threshold (increments of 6 months)

    final cycleStats = await predictionService.getPredictionStats(userId);

    //if app calendar must show predicted cycles it needs to know where to start from
    //the last recorded cycle can be either a completed cycle or an ongoing one
    //to simplify we take the start date of the last recorded cycle regardless of whether it's completed or ongoing
    //UI will be responsible for displaying predicted days that are part of ongoing cycle.

    //retrieve last recorded cycle
    final lastCycle = await CycleRepository().findLatestRecordedCycle(userId);
    if (lastCycle != null) {
      var startDate = lastCycle.startDate;
      //Use start date of last recorded cycle to base predictions on
      var rawNumberOfCyclesFromLastCycle =
          (DateTime(focusedDay.year, focusedDay.month + 1, 1)
                  .difference(DateTime(startDate!.year, startDate.month, 1))
                  .inDays) /
              30 /
              cycleStats['averageCycleLength'];
      var numberOfCyclesFromLastCycle = rawNumberOfCyclesFromLastCycle.ceil();

      if (numberOfCyclesFromLastCycle < 24) {
        numberOfCyclesFromLastCycle = 24;
      }

      for (int i = 0; i < numberOfCyclesFromLastCycle; i++) {
        var predictedCycleStart = startDate
            .add(Duration(days: cycleStats['averageCycleLength'] * (i + 1)));
        var predictedCycle = Cycle(
            userId: userId,
            startDate: predictedCycleStart,
            endDate: predictedCycleStart
                .add(Duration(days: cycleStats['averageCycleLength'] - 1)),
            periodEndDate: predictedCycleStart
                .add(Duration(days: cycleStats['averagePeriodLength'] - 1)));
        var key = predictedCycle.startDate!.toIso8601String().substring(0, 10);
        _predictedCycles[key] = predictedCycle;
      }

      //add a tail condition to monitor which months to delete
      if (_predictedCycles.length > 24) {
        //clear existing predictions if they exceed the new calculation
        if (tail) {
          _predictedCycles.removeWhere((key, value) => value.startDate!
              .isBefore(focusedDay.subtract(Duration(days: 365))));
        } else {
          _predictedCycles.removeWhere((key, value) =>
              value.startDate!.isAfter(focusedDay.add(Duration(days: 365))));
        }
      }
    }
  }

  void selectDay(DateTime selectedDay) {
    emit(CalendarDaySelected(selectedDay: selectedDay));
  }

//handle scroll events to load more months dynamically using a threshold
  Future<void> handleScroll(DateTime focusedDay) async {
    // Determine the range of cached Days and predicted cycles
    //cached days
    final List<String> sortedKeys = _cachedDays.keys.toList()..sort();
    final String firstKey = sortedKeys.first;
    final String lastKey = sortedKeys.last;
    final DateTime firstCachedMonth = DateTime.parse('$firstKey-01');
    final DateTime lastCachedMonth = DateTime.parse('$lastKey-01');

    // Calculate dynamic threshold for conditional fetching
    final int cacheSize = _cachedDays.length;
    final int threshold = (cacheSize / _thresholdFactor).ceil();
    //fetch more months if focusedDay is beyond threshold
    if (focusedDay
        .isBefore(firstCachedMonth.subtract(Duration(days: threshold * 30)))) {
      // Fetch earlier months (tail)
      await _fetchMoreMonths(tail: true, referenceMonth: firstCachedMonth);
    } else if (focusedDay
        .isAfter(lastCachedMonth.add(Duration(days: threshold * 30)))) {
      // Fetch later months (head)
      await _fetchMoreMonths(tail: false, referenceMonth: lastCachedMonth);
    }

    //predicted cycles
    final List<String> sortedPredictedKeys = _predictedCycles.keys.toList()
      ..sort();
    final String firstPredictedKey = sortedPredictedKeys.first;
    final String lastPredictedKey = sortedPredictedKeys.last;
    final DateTime firstPredictedMonth = DateTime.parse('$firstPredictedKey');
    final DateTime lastPredictedMonth = DateTime.parse('$lastPredictedKey');
    final lastCycle = await CycleRepository()
        .findLatestRecordedCycle(userId); //ToDo: add condition to avoid null
    final cycleStats = await predictionService.getPredictionStats(userId);
    final lastCycleStartDate = lastCycle?.startDate;
    //Calculate predicted cycles after loading more months

    //Scroll event must determine if more predictions should be loaded into cache and
    //needs to the decide on which side of the cache to add more predictions
    //based on the focusedDay position
    if (focusedDay.isBefore(firstPredictedMonth.add(Duration(days: 180))) &&
        focusedDay.difference(lastCycleStartDate!) > Duration(days: 180)) {
      // add a check to avoid loading predictions that already exist between the lastCycle and focusedDay

      populateCyclePredictionCache(focusedDay,
          false); //load more predictions at head since focusedDay is within 6 months of first predicted month
    } else if (focusedDay
        .isAfter(lastPredictedMonth.subtract(Duration(days: 180)))) {
      populateCyclePredictionCache(focusedDay,
          true); //load more predictions at tail since focusedDay is within 6 months of last predicted month
    }
    emit(CalendarLoaded(cachedmonths: _cachedDays, predictedCycles: {}));
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
