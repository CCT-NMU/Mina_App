part of 'cycle_tracker_bloc.dart';

sealed class CycleTrackerState extends Equatable {
  final Cycle? presentCycle;
  const CycleTrackerState({this.presentCycle});

  @override
  List<Object> get props => [presentCycle ?? Object()];
}

final class CycleTrackerInitial extends CycleTrackerState {
  const CycleTrackerInitial({Cycle? presentCycle})
      : super(presentCycle: presentCycle);
}

//upon updated event renew data dependencies and emit this state to update all dependant UI
final class CycleTrackerUpdated extends CycleTrackerState {
  const CycleTrackerUpdated({Cycle? presentCycle})
      : super(presentCycle: presentCycle);
}

final class CycleTrackerCycleFetched extends CycleTrackerState {
  final Cycle focusedDayCycle;
  const CycleTrackerCycleFetched(this.focusedDayCycle, {Cycle? presentCycle})
      : super(presentCycle: presentCycle);

  @override
  List<Object> get props => [
        focusedDayCycle,
        presentCycle ??
            Cycle(
                startDate: DateTime(0, 0, 0),
                endDate: null,
                periodEndDate: null)
      ];
}
