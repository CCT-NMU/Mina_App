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
  final bool isPeriodDay;
  final List<String> selectedSymptoms;
  final List<String> selectedMoods;
  final String notes;

  const DayEntryLoadedState({
    required this.date,
    required this.isPeriodDay,
    required this.selectedSymptoms,
    required this.selectedMoods,
    required this.notes,
  });

  @override
  List<Object> get props =>
      [date, isPeriodDay, selectedSymptoms, selectedMoods, notes];

  copyWith({
    DateTime? date,
    bool? isPeriodDaySelected,
    List<String>? selectedSymptoms,
    List<String>? selectedMoods,
    String? notes,
  }) =>
      DayEntryLoadedState(
          date: date ?? this.date,
          isPeriodDay: isPeriodDaySelected ?? this.isPeriodDay,
          selectedSymptoms: selectedSymptoms ?? this.selectedSymptoms,
          selectedMoods: selectedMoods ?? this.selectedMoods,
          notes: notes ?? this.notes);
}

class DayEntryInPresentCycleState extends DayEntryLoadedState {
  DayEntryInPresentCycleState(
      {required super.date,
      required super.isPeriodDay,
      required super.selectedSymptoms,
      required super.selectedMoods,
      required super.notes});
}

class DayEntryInHistoricalCycleState extends DayEntryLoadedState {
  DayEntryInHistoricalCycleState(
      {required super.date,
      required super.isPeriodDay,
      required super.selectedSymptoms,
      required super.selectedMoods,
      required super.notes});
}

class FutureDayEntryOutOfCycleState extends DayEntryLoadedState {
  FutureDayEntryOutOfCycleState(
      {required super.date,
      required super.isPeriodDay,
      required super.selectedSymptoms,
      required super.selectedMoods,
      required super.notes});
}

class PastDayEntryOutOfCycleState extends DayEntryLoadedState {
  PastDayEntryOutOfCycleState(
      {required super.date,
      required super.isPeriodDay,
      required super.selectedSymptoms,
      required super.selectedMoods,
      required super.notes});
}

class PeriodDayEntryLoadedState extends DayEntryBlocState {
  final DateTime date;
  final bool isPeriodDay;
  final bool isPeriodEndDay;
  final bool isPeriodStartDay;
  final List<String> selectedSymptoms;
  final String? selectedFlow;
  final List<String> selectedMoods;
  final String notes;

  const PeriodDayEntryLoadedState({
    required this.date,
    required this.isPeriodDay,
    required this.isPeriodEndDay,
    required this.isPeriodStartDay,
    required this.selectedFlow,
    required this.selectedSymptoms,
    required this.selectedMoods,
    required this.notes,
  });

  @override
  List<Object> get props => [
        isPeriodDay,
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
          isPeriodDay: isPeriodDaySelected ?? this.isPeriodDay,
          isPeriodEndDay: isPeriodEndDay ?? this.isPeriodEndDay,
          isPeriodStartDay: isPeriodStartDay ?? this.isPeriodStartDay,
          selectedFlow: selectedFlow ?? this.selectedFlow,
          selectedSymptoms: selectedSymptoms ?? this.selectedSymptoms,
          selectedMoods: selectedMoods ?? this.selectedMoods,
          notes: notes ?? this.notes);
}

class PeriodDayEntryOngoingPeriodState extends PeriodDayEntryLoadedState {
  PeriodDayEntryOngoingPeriodState(
      {required super.date,
      required super.isPeriodDay,
      required super.isPeriodEndDay,
      required super.isPeriodStartDay,
      required super.selectedFlow,
      required super.selectedSymptoms,
      required super.selectedMoods,
      required super.notes});
}

class PeriodDayEntryInHistoricalCycleState extends PeriodDayEntryLoadedState {
  PeriodDayEntryInHistoricalCycleState(
      {required super.date,
      required super.isPeriodDay,
      required super.isPeriodEndDay,
      required super.isPeriodStartDay,
      required super.selectedFlow,
      required super.selectedSymptoms,
      required super.selectedMoods,
      required super.notes});
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
