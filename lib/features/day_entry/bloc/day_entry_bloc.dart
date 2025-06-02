import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_event.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_state.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayEntryBloc extends Bloc<DayEntryBlocEvent, DayEntryBlocState> {
  DayEntryBloc() : super(const DayEntryInitialState()) {
    on<DayEntryFetch>((event, emit) async {
      emit(const DayEntryLoadingState());
      try {
        //ToDo remove additional database query. getDay will return a Period Day if exists
        final day = await DayEntryRepository.instance.getDayEntry(event.date);
        if (day != null) {
          if (day is PeriodDay) {
            emit(PeriodDayEntryLoadedState(
              isPeriodDaySelected: day.isPeriodDay,
              selectedFlow: day.flowWeight.toString(),
              selectedSymptoms: day.symptomList?.symptoms ?? [],
              selectedMoods: day.moodList?.moods ?? [],
              notes: day.note ?? '',
            ));
            return;
          }

          emit(DayEntryLoadedState(
            isPeriodDaySelected: day.isPeriodDay,
            selectedSymptoms: day.symptomList?.symptoms ?? [],
            selectedMoods: day.moodList?.moods ?? [],
            notes: day.note ?? '',
          ));
          return;
        } else {
          emit(const DayEntryLoadedState(
            isPeriodDaySelected: false,
            selectedSymptoms: [],
            selectedMoods: [],
            notes: '',
          ));
        }
      } catch (e) {
        emit(const DayEntryErrorState('Failed to load day entry'));
      }
    });

    on<FlowChanged>((event, emit) {
      if (state is PeriodDayEntryLoadedState) {
        final s = state as PeriodDayEntryLoadedState;
        emit(PeriodDayEntryLoadedState(
          isPeriodDaySelected: s.isPeriodDaySelected,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
      if (state is DayEntryLoadedState) {
        final s = state as DayEntryLoadedState;
        emit(DayEntryLoadedState(
          isPeriodDaySelected: s.isPeriodDaySelected,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
    });

    on<SymptomsChanged>((event, emit) {
      if (state is PeriodDayEntryLoadedState) {
        final s = state as PeriodDayEntryLoadedState;
        emit(PeriodDayEntryLoadedState(
          isPeriodDaySelected: s.isPeriodDaySelected,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
      if (state is DayEntryLoadedState) {
        final s = state as DayEntryLoadedState;
        emit(DayEntryLoadedState(
          isPeriodDaySelected: s.isPeriodDaySelected,
          selectedSymptoms: event.symptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
    });

    on<MoodsChanged>((event, emit) {
      if (state is PeriodDayEntryLoadedState) {
        final s = state as PeriodDayEntryLoadedState;
        emit(PeriodDayEntryLoadedState(
          isPeriodDaySelected: s.isPeriodDaySelected,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
      if (state is DayEntryLoadedState) {
        final s = state as DayEntryLoadedState;
        emit(DayEntryLoadedState(
          isPeriodDaySelected: s.isPeriodDaySelected,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: event.moods,
          notes: s.notes,
        ));
      }
    });

    on<PeriodDaySelectedChanged>((event, emit) {
      if (state is PeriodDayEntryLoadedState) {
        final s = state as PeriodDayEntryLoadedState;
        emit(PeriodDayEntryLoadedState(
          isPeriodDaySelected: s.isPeriodDaySelected,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
      if (state is DayEntryLoadedState) {
        final s = state as DayEntryLoadedState;
        emit(DayEntryLoadedState(
          isPeriodDaySelected: s.isPeriodDaySelected,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
    });

    on<NotesChanged>((event, emit) {
      if (state is PeriodDayEntryLoadedState) {
        final s = state as PeriodDayEntryLoadedState;
        emit(PeriodDayEntryLoadedState(
          isPeriodDaySelected: s.isPeriodDaySelected,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
      if (state is DayEntryLoadedState) {
        final s = state as DayEntryLoadedState;
        emit(DayEntryLoadedState(
          isPeriodDaySelected: s.isPeriodDaySelected,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
    });
  }
}
