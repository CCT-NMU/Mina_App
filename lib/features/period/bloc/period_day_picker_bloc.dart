import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/period/period_picker_logic.dart';
import 'period_day_picker_event.dart';
import 'period_day_picker_state.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:flutter/foundation.dart';

class PeriodDayPickerBloc
    extends Bloc<PeriodDayPickerEvent, PeriodDayPickerState> {
  PeriodDayPickerBloc() : super(const PeriodDayPickerState()) {
    on<PeriodDaysFetched>(_onFetched);
    on<PeriodDayToggled>(_onToggled);
    on<SavedPeriodDays>(_onSavedPeriodDays);
    on<LoadMoreMonthsForward>(_onLoadMoreMonthsForward);
    on<LoadMoreMonthsBackward>(_onLoadMoreMonthsBackward);
  }

  Future<void> _onFetched(
    PeriodDaysFetched event,
    Emitter<PeriodDayPickerState> emit,
  ) async {
    emit(state.copyWith(status: PeriodDayPickerStatus.loading));
    try {
      final now = DateTime.now();
      List<Day> periodDays = await DatabaseHelper().getPeriodDaysInRange(
        DateTime(1960, 1, 1),
        DateTime(now.year + 1, now.month + 2, 0),
      );
      // Generate a list of months going back 12 months starting 1 month in the future from the focused day's month.
      // Start from 1 month in the future from the focused day's month, go back 12 months
      List<DateTime> initialMonths = List.generate(
        12,
        (i) {
          int month = event.focusedDay.month + 1 - i;
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
  void _onSavedPeriodDays(
    SavedPeriodDays event,
    Emitter<PeriodDayPickerState> emit,
  ) {
    PeriodPicker()
        .saveEditedDays(state.selectedDays, state.oldDays, event.context);
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
    emit(state.copyWith(selectedDays: selected));
  }

  static Set<DateTime> _processPeriodDaySetIsolate(List<Day> periodDays) {
    return periodDays
        .map((day) => DateTime(day.date.year, day.date.month, day.date.day))
        .toSet();
  }

  static const int windowSize = 12;

  void _onLoadMoreMonthsForward(
    LoadMoreMonthsForward event,
    Emitter<PeriodDayPickerState> emit,
  ) {
    final lastMonth = state.months.last;
    final newMonths = List<DateTime>.generate(
      6, // or any number of months to add
      (i) => DateTime(lastMonth.year + ((lastMonth.month + i) ~/ 12),
          ((lastMonth.month + i) % 12) + 1, 1),
    );
    var updatedMonths = [...state.months, ...newMonths];
    if (updatedMonths.length > windowSize) {
      updatedMonths = updatedMonths.sublist(updatedMonths.length - windowSize);
    }
    emit(state.copyWith(months: updatedMonths));
  }

  void _onLoadMoreMonthsBackward(
    LoadMoreMonthsBackward event,
    Emitter<PeriodDayPickerState> emit,
  ) {
    final firstMonth = state.months.first;

    final newMonths = List<DateTime>.generate(
      6,
      (i) {
        int month = firstMonth.month - (i + 1);
        int year = firstMonth.year;
        while (month < 1) {
          month += 12;
          year -= 1;
        }
        return DateTime(year, month, 1);
      },
    ).reversed.toList();
    var updatedMonths = [...state.months, ...newMonths];
    // Remove from the end if over window size
    if (updatedMonths.length > windowSize) {
      updatedMonths = updatedMonths.sublist(0, windowSize);
    }
    emit(state.copyWith(months: updatedMonths));
  }

  @override
  void onTransition(
      Transition<PeriodDayPickerEvent, PeriodDayPickerState> transition) {
    super.onTransition(transition);

    print('Transition: ${transition.event} '
        'from ${transition.currentState.months.length} months '
        'to ${transition.nextState.months.length} months');
  }
}
