part of 'cycle_tracker_bloc.dart';

sealed class CycleTrackerState extends Equatable {
  const CycleTrackerState();

  @override
  List<Object> get props => [];
}

final class CycleTrackerInitial extends CycleTrackerState {}

//upon updated event renew data dependencies and emit this state to update all dependant UI
final class CycleTrackerUpdated extends CycleTrackerState {}

final class CycleTrackerCurrent extends CycleTrackerState {
  final Cycle currentCycle;
  const CycleTrackerCurrent(this.currentCycle);

  @override
  List<Object> get props => [currentCycle];
}
