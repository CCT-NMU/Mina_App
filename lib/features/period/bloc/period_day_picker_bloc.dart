import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/services/auth_service.dart';
import 'period_day_picker_event.dart';
import 'period_day_picker_state.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:flutter/foundation.dart';

class PeriodDayPickerBloc
    extends Bloc<PeriodDayPickerEvent, PeriodDayPickerState> {
  final String userId;

  PeriodDayPickerBloc({required this.userId})
      : super(const PeriodDayPickerState()) {
    on<PeriodDaysFetched>(_onFetched);
    on<PeriodDayToggled>(_onToggled);
  }

  Future<void> _onFetched(
    PeriodDaysFetched event,
    Emitter<PeriodDayPickerState> emit,
  ) async {
    emit(state.copyWith(status: PeriodDayPickerStatus.loading));
    try {
      // Check authentication before proceeding
      if (!AuthService.instance.isLoggedIn) {
        debugPrint('User not authenticated in PeriodDayPickerBloc');
        emit(state.copyWith(status: PeriodDayPickerStatus.failure));
        return;
      }

      final now = DateTime.now();
      // Use DayEntryRepository instead of DatabaseHelper directly
      List<Day> periodDays =
          await DayEntryRepository.instance.getPeriodDaysInRange(
        DateTime(1960, 1, 1),
        DateTime(now.year + 1, now.month + 2, 0),
        userId,
      );
      final Set<DateTime> processed =
          await compute(_processPeriodDaySetIsolate, periodDays);
      emit(state.copyWith(
        status: PeriodDayPickerStatus.success,
        oldDays: processed,
        selectedDays: processed,
      ));
    } catch (e) {
      debugPrint('Error in PeriodDayPickerBloc._onFetched: $e');
      // Check if it's an authentication error
      if (e.toString().contains('No authenticated user found')) {
        debugPrint('Authentication error in period picker');
      }
      emit(state.copyWith(status: PeriodDayPickerStatus.failure));
    }
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
}
