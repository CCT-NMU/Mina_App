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
  final Day day;

  const DayEntryLoadedState(this.day);

  @override
  List<Object> get props => [day];
}

class PeriodDayEntryLoadedState extends DayEntryBlocState {
  final PeriodDay periodDay;

  const PeriodDayEntryLoadedState(this.periodDay);

  @override
  List<Object> get props => [periodDay];
}

//New Day entry to be created
class NewDayEntryState extends DayEntryBlocState {
  const NewDayEntryState();
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
