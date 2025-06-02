part of 'cycle_tracker_bloc.dart';

sealed class CycleTrackerEvent extends Equatable {
  const CycleTrackerEvent();

  @override
  List<Object> get props => [];
}

// cycle updated
class CycleUpdated extends CycleTrackerEvent {
  final Cycle cycle;
  const CycleUpdated(this.cycle);
}

// cycle fetch
class CycleFetch extends CycleTrackerEvent {
  const CycleFetch();
}

//check day in cycle
class FetchCurrentCycle extends CycleTrackerEvent {}

// cycle delete
class CycleDelete extends CycleTrackerEvent {
  const CycleDelete();
}
