import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/features/period_picker/period_picker_logic.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:flutter/foundation.dart';
part 'period_day_picker_event.dart';
part 'period_day_picker_state.dart';

class PeriodDayPickerBloc
    extends Bloc<PeriodDayPickerEvent, PeriodDayPickerState> {
  final DayEntryRepository dayEntryRepository;
  PeriodDayPickerBloc(this.dayEntryRepository)
      : super(const PeriodDayPickerState()) {
    on<PeriodDaysFetched>(_onFetched);
    on<PeriodDayToggled>(_onToggled);
    on<SavedPeriodDays>(_onSavedPeriodDays);
    on<LoadMoreMonthsForward>(_onLoadMoreMonthsForward);
    on<LoadMoreMonthsBackward>(_onLoadMoreMonthsBackward);
    on<PeriodDayPickerUptake>(_onUptake);
  }

  void _onUptake(
    PeriodDayPickerUptake event,
    Emitter<PeriodDayPickerState> emit,
  ) {
    emit(state.copyWith(
      status: PeriodDayPickerStatus.loading,
    ));
    List<DateTime> initialMonths = List.generate(
      24,
      (i) {
        int month = event.focusedDay.month - i + 1;
        int year = event.focusedDay.year;
        while (month < 1) {
          month += 12;
          year -= 1;
        }
        return DateTime(year, month, 1);
      },
    ).toList();
    // Initialize the state with the focused day and userId
    emit(state.copyWith(
      selectedDays: const {},
      oldDays: const {},
      months: initialMonths,
      status: PeriodDayPickerStatus.initial,
    ));
  }

  Future<void> _onFetched(
    PeriodDaysFetched event,
    Emitter<PeriodDayPickerState> emit,
  ) async {
    emit(state.copyWith(status: PeriodDayPickerStatus.loading));
    try {
      final now = DateTime.now();
      List<Day> periodDays = await dayEntryRepository.getPeriodDaysInRange(
          DateTime(1960, 1, 1),
          DateTime(now.year + 1, now.month + 1, 0),
          event.userId);
      // Generate a list of months going back 12 months starting 1 month in the future from the focused day's month.
      // Start from 2 month in the future from the focused day's month, go back 12 months
      List<DateTime> initialMonths = List.generate(
        24,
        (i) {
          int month = event.focusedDay.month - i + 1;
          int year = event.focusedDay.year;
          while (month < 1) {
            month += 12;
            year -= 1;
          }
          return DateTime(year, month, 1);
        },
      ).toList();
      final Set<DateTime> processed =
          await compute(_processPeriodDaySetIsolate, periodDays);
      emit(state.copyWith(
        status: PeriodDayPickerStatus.success,
        oldDays: processed,
        selectedDays: processed,
        months: initialMonths,
      ));
    } catch (_) {
      emit(state.copyWith(status: PeriodDayPickerStatus.failure));
    }
  }

  /// Call PeriodPicker().saveEditedDays() with the state.selectedDays and
  /// state.oldDays. This is a wrapper for the method that is used to save the
  /// selected period days.
  Future<void> _onSavedPeriodDays(
    SavedPeriodDays event,
    Emitter<PeriodDayPickerState> emit,
  ) async {
    emit(state.copyWith(status: PeriodDayPickerStatus.saving));
    var result = await PeriodPickerLogic(
            event.userId, dayEntryRepository, event.isOnboarding)
        .saveEditedDays(state.selectedDays, state.oldDays);
    if (result == true)
      emit(state.copyWith(status: PeriodDayPickerStatus.success));
  }

  void _onToggled(
    PeriodDayToggled event,
    Emitter<PeriodDayPickerState> emit,
  ) {
    final normalized = DateTime(event.day.year, event.day.month, event.day.day);
    final selected = Set<DateTime>.from(state.selectedDays);
    if (selected.contains(normalized)) {
      selected.remove(normalized);
    } else {
      selected.add(normalized);
    }
    emit(state.copyWith(
      selectedDays: selected,
      preservedScrollIndex: null,
      monthsAdded: 0,
    ));
  }

  static Set<DateTime> _processPeriodDaySetIsolate(List<Day> periodDays) {
    return periodDays
        .map((day) => DateTime(day.date.year, day.date.month, day.date.day))
        .toSet();
  }

  static const int windowSize = 24;

  void _onLoadMoreMonthsForward(
    LoadMoreMonthsForward event,
    Emitter<PeriodDayPickerState> emit,
  ) {
    final firstMonth = state.months.first;
    if (firstMonth.isAfter(DateTime.now())) return;
    final newMonths = List<DateTime>.generate(
      12, // or any number of months to add
      (i) => DateTime(firstMonth.year + ((firstMonth.month + i) ~/ 12),
          ((firstMonth.month + i) % 12) + 1, 1),
    ).reversed.toList();
    var updatedMonths = [
      ...newMonths,
      ...state.months,
    ];
    if (updatedMonths.length > windowSize) {
      updatedMonths = updatedMonths.sublist(0, windowSize);
    }
    final preservedIndex = event.preservedIndex + newMonths.length;
    emit(state.copyWith(
      months: updatedMonths,
      monthsAdded: newMonths.length,
      preservedScrollIndex: preservedIndex,
      leadingEdge: event.leadingEdge,
    ));
  }

  void _onLoadMoreMonthsBackward(
    LoadMoreMonthsBackward event,
    Emitter<PeriodDayPickerState> emit,
  ) {
    final lastMonth = state.months.last;

    final newMonths = List<DateTime>.generate(
      12,
      (i) {
        int month = lastMonth.month - (i + 1);
        int year = lastMonth.year;
        while (month < 1) {
          month += 12;
          year -= 1;
        }
        return DateTime(year, month, 1);
      },
    ).toList();
    var updatedMonths = [
      ...state.months,
      ...newMonths,
    ];
    final preservedIndex =
        event.preservedIndex - updatedMonths.length + windowSize;

    if (updatedMonths.length > windowSize) {
      updatedMonths = updatedMonths.sublist(
          updatedMonths.length - windowSize, updatedMonths.length);
    }

    emit(state.copyWith(
      months: updatedMonths,
      monthsAdded: newMonths.length,
      preservedScrollIndex: preservedIndex,
      leadingEdge: event.leadingEdge,
    ));
  }

  @override
  void onTransition(
      Transition<PeriodDayPickerEvent, PeriodDayPickerState> transition) {
    super.onTransition(transition);

    print('Transition: ${transition.event} '
        'from ${transition.currentState.status}  '
        'to ${transition.nextState.status} ');
  }
}
