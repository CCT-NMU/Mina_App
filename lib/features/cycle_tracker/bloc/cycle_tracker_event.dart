part of 'cycle_tracker_bloc.dart';

sealed class CycleTrackerEvent extends Equatable {
  const CycleTrackerEvent();

  @override
  List<Object> get props => [];
}

class CycleTrackerStarted extends CycleTrackerEvent {
  const CycleTrackerStarted();
}

// cycle updated
class CyclesUpdated extends CycleTrackerEvent {
  const CyclesUpdated();
}

// cycle fetch
class FetchCycle extends CycleTrackerEvent {
  final DateTime date;
  const FetchCycle(this.date);
}
