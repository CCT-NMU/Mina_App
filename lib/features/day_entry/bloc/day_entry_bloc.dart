import 'dart:math';

import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/model/symptom_list.dart';
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
              date: day.date,
              isPeriodDaySelected: day.isPeriodDay,
              isPeriodStartDay: day.isPeriodStartDay,
              isPeriodEndDay: day.isPeriodEndDay,
              selectedFlow: day.flowWeight.index.toString(),
              selectedSymptoms: day.symptomList?.symptoms ?? [],
              selectedMoods: day.moodList?.moods ?? [],
              notes: day.note ?? '',
            ));
            return;
          }

          emit(DayEntryLoadedState(
            date: day.date,
            isPeriodDaySelected: day.isPeriodDay,
            selectedSymptoms: day.symptomList?.symptoms ?? [],
            selectedMoods: day.moodList?.moods ?? [],
            notes: day.note ?? '',
          ));
          return;
        } else {
          emit(DayEntryLoadedState(
            date: event.date,
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
          date: s.date,
          isPeriodDaySelected: s.isPeriodDaySelected,
          isPeriodEndDay: s.isPeriodEndDay,
          isPeriodStartDay: s.isPeriodStartDay,
          selectedFlow: event.flow,
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
          date: s.date,
          isPeriodDaySelected: s.isPeriodDaySelected,
          isPeriodEndDay: s.isPeriodEndDay,
          isPeriodStartDay: s.isPeriodStartDay,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: event.symptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
      if (state is DayEntryLoadedState) {
        final s = state as DayEntryLoadedState;
        emit(DayEntryLoadedState(
          date: s.date,
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
          date: s.date,
          isPeriodDaySelected: s.isPeriodDaySelected,
          isPeriodStartDay: s.isPeriodStartDay,
          isPeriodEndDay: s.isPeriodEndDay,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: event.moods,
          notes: s.notes,
        ));
      }
      if (state is DayEntryLoadedState) {
        final s = state as DayEntryLoadedState;
        emit(DayEntryLoadedState(
          date: s.date,
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
          date: s.date,
          isPeriodDaySelected: event.isPeriodDaySelected,
          isPeriodStartDay: s.isPeriodStartDay,
          isPeriodEndDay: s.isPeriodEndDay,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
      if (state is DayEntryLoadedState) {
        final s = state as DayEntryLoadedState;
        emit(DayEntryLoadedState(
          date: s.date,
          isPeriodDaySelected: event.isPeriodDaySelected,
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
          date: s.date,
          isPeriodDaySelected: s.isPeriodDaySelected,
          isPeriodStartDay: s.isPeriodStartDay,
          isPeriodEndDay: s.isPeriodEndDay,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: event.notes,
        ));
      }
      if (state is DayEntryLoadedState) {
        final s = state as DayEntryLoadedState;
        emit(DayEntryLoadedState(
          date: s.date,
          isPeriodDaySelected: s.isPeriodDaySelected,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: event.notes,
        ));
      }
    });

    on<DayEntryInsertOrUpdate>((event, emit) async {
      if (state is PeriodDayEntryLoadedState) {
        final s = state as PeriodDayEntryLoadedState;
        DayEntryRepository.instance.insertPeriodDayEntry(
            PeriodDay(
                date: s.date,
                flowWeight:
                    PeriodDay.flowWeightValues[int.parse(s.selectedFlow!)],
                symptomList: SymptomList(symptoms: s.selectedSymptoms),
                moodList: MoodList(moods: s.selectedMoods),
                isPeriodStartDay: s.isPeriodStartDay,
                isPeriodEndDay: s.isPeriodEndDay,
                note: s.notes),
            null);
        return;
      }
      if (state is DayEntryLoadedState) {
        final s = state as DayEntryLoadedState;
        DayEntryRepository.instance.insertDayEntry(Day(
            date: s.date,
            isPeriodDay: s.isPeriodDaySelected,
            symptomList: SymptomList(symptoms: s.selectedSymptoms),
            moodList: MoodList(moods: s.selectedMoods),
            note: s.notes));
      }
    });
  }
}
