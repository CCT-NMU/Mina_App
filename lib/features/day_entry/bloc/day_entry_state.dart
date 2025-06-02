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
  final bool isPeriodDaySelected;
  final List<String> selectedSymptoms;
  final List<String> selectedMoods;
  final String notes;

  const DayEntryLoadedState({
    required this.isPeriodDaySelected,
    required this.selectedSymptoms,
    required this.selectedMoods,
    required this.notes,
  });

  @override
  List<Object> get props =>
      [isPeriodDaySelected, selectedSymptoms, selectedMoods, notes];
}

class PeriodDayEntryLoadedState extends DayEntryBlocState {
  final bool isPeriodDaySelected;
  final List<String> selectedSymptoms;
  final String? selectedFlow;
  final List<String> selectedMoods;
  final String notes;

  const PeriodDayEntryLoadedState({
    required this.isPeriodDaySelected,
    required this.selectedFlow,
    required this.selectedSymptoms,
    required this.selectedMoods,
    required this.notes,
  });

  @override
  List<Object> get props => [
        isPeriodDaySelected,
        selectedFlow ?? "0",
        selectedSymptoms,
        selectedMoods,
        notes
      ];
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
