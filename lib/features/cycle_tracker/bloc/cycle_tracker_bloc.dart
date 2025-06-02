import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';

part 'cycle_tracker_event.dart';
part 'cycle_tracker_state.dart';

class CycleTrackerBloc extends Bloc<CycleTrackerEvent, CycleTrackerState> {
  CycleTrackerBloc() : super(CycleTrackerInitial()) {
    on<CycleFetch>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchCurrentCycle>((event, emit) async {
      final currentCycle = await CycleRepository().getCurrentCycle();
      if (currentCycle != null) {
        emit(CycleTrackerCurrent(currentCycle));
      }
    });
  }
}
