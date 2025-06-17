import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';

part 'cycle_tracker_event.dart';
part 'cycle_tracker_state.dart';

class CycleTrackerBloc extends Bloc<CycleTrackerEvent, CycleTrackerState> {
  CycleTrackerBloc() : super(CycleTrackerInitial()) {
    //On dashboard startup
    on<CycleTrackerStarted>((event, emit) async {
      //fetch the global cycle
      final cycle = await CycleRepository().getPresentCycle();

      //global cycle can be null
      if (cycle != null) {
        emit(CycleTrackerInitial(presentCycle: cycle));
      } else {
        emit(CycleTrackerInitial());
      }
    });

    //Fetch the cycle for the current date
    //Emit no Cycle exists state for
    on<FetchCycle>((event, emit) async {
      print("fetching cycle for ${event.date}");
      final currentCycle = await CycleRepository().getCycle(event.date);
      if (currentCycle != null) {
        print("Cycle found for ${event.date}");
        emit(CycleTrackerCycleFetched(currentCycle,
            presentCycle: state.presentCycle));
      } else
      //Use to omit Day-Entry features that require a cycle
      //For creating day entry older than the recorded cycle
      {
        print("No cycle found for ${event.date}");
        (emit(CycleTrackerInitial(presentCycle: state.presentCycle)));
      }
    });
  }
  @override
  void onTransition(
      Transition<CycleTrackerEvent, CycleTrackerState> transition) {
    super.onTransition(transition);

    print('Transition: ${transition.event} '
        'from ${transition.currentState.presentCycle}'
        'to ${transition.nextState.presentCycle}');
  }
}
