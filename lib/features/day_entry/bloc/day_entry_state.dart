//Class to describe the states that the DayEntryBloc can be in

import 'package:equatable/equatable.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/model/period_day.dart';

abstract class DayEntryBlocState extends Equatable {
  const DayEntryBlocState();

  @override
  List<Object> get props => [];
}

// Initial state
class DayEntryInitialState extends DayEntryBlocState {
  const DayEntryInitialState();
}

// Loading state
class DayEntryLoadingState extends DayEntryBlocState {
  const DayEntryLoadingState();
}

// Loaded state
class DayEntryLoadedState extends DayEntryBlocState {
  final DateTime date;
  final bool isPeriodDaySelected;
  final List<String> selectedSymptoms;
  final List<String> selectedMoods;
  final String notes;

  const DayEntryLoadedState({
    required this.date,
    required this.isPeriodDaySelected,
    required this.selectedSymptoms,
    required this.selectedMoods,
    required this.notes,
  });

  @override
  List<Object> get props =>
      [date, isPeriodDaySelected, selectedSymptoms, selectedMoods, notes];

  copyWith({
    DateTime? date,
    bool? isPeriodDaySelected,
    List<String>? selectedSymptoms,
    List<String>? selectedMoods,
    String? notes,
  }) =>
      DayEntryLoadedState(
          date: date ?? this.date,
          isPeriodDaySelected: isPeriodDaySelected ?? this.isPeriodDaySelected,
          selectedSymptoms: selectedSymptoms ?? this.selectedSymptoms,
          selectedMoods: selectedMoods ?? this.selectedMoods,
          notes: notes ?? this.notes);
}

class PeriodDayEntryLoadedState extends DayEntryBlocState {
  final DateTime date;
  final bool isPeriodDaySelected;
  final bool isPeriodEndDay;
  final bool isPeriodStartDay;
  final List<String> selectedSymptoms;
  final String? selectedFlow;
  final List<String> selectedMoods;
  final String notes;

  const PeriodDayEntryLoadedState({
    required this.date,
    required this.isPeriodDaySelected,
    required this.isPeriodEndDay,
    required this.isPeriodStartDay,
    required this.selectedFlow,
    required this.selectedSymptoms,
    required this.selectedMoods,
    required this.notes,
  });

  @override
  List<Object> get props => [
        isPeriodDaySelected,
        isPeriodEndDay,
        isPeriodStartDay,
        selectedFlow ?? "0",
        selectedSymptoms,
        selectedMoods,
        notes
      ];

  copyWith({
    DateTime? date,
    bool? isPeriodDaySelected,
    bool? isPeriodEndDay,
    bool? isPeriodStartDay,
    String? selectedFlow,
    List<String>? selectedSymptoms,
    List<String>? selectedMoods,
    String? notes,
  }) =>
      PeriodDayEntryLoadedState(
          date: date ?? this.date,
          isPeriodDaySelected: isPeriodDaySelected ?? this.isPeriodDaySelected,
          isPeriodEndDay: isPeriodEndDay ?? this.isPeriodEndDay,
          isPeriodStartDay: isPeriodStartDay ?? this.isPeriodStartDay,
          selectedFlow: selectedFlow ?? this.selectedFlow,
          selectedSymptoms: selectedSymptoms ?? this.selectedSymptoms,
          selectedMoods: selectedMoods ?? this.selectedMoods,
          notes: notes ?? this.notes);
}

// Saved state
class DayEntrySavedState extends DayEntryBlocState {
  const DayEntrySavedState();
}

// Deleted state
class DayEntryDeletedState extends DayEntryBlocState {
  const DayEntryDeletedState();
}

// Error state
class DayEntryErrorState extends DayEntryBlocState {
  final String message;

  const DayEntryErrorState(this.message);

  @override
  List<Object> get props => [message];
}
