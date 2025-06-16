import 'dart:math';

import 'package:mina_app/common/utils.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/model/symptom_list.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_event.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_state.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/day_entry/view/day_entry_form.dart';

class DayEntryBloc extends Bloc<DayEntryBlocEvent, DayEntryBlocState> {
  DayEntryBloc() : super(const DayEntryInitialState()) {
    on<DayEntryFetch>((event, emit) async {
      emit(const DayEntryLoadingState());
      try {
        //find if day exists
        final day = await DayEntryRepository.instance.getDayEntry(event.date);
        //find if day is in present cycle

        final presentCycle = await CycleRepository().getPresentCycle();

        bool isInPresentCycle = false;
        if (presentCycle != null) {
          isInPresentCycle = isInPresentCycle =
              presentCycle.isInCycle(Utils().normalizedDate(event.date));
        }

        if (day != null) {
          if (day is PeriodDay) {
            //check if day is in the present cycle

            if (isInPresentCycle == true) {
              emit(PeriodDayEntryOngoingPeriodState(
                date: day.date,
                isPeriodDay: day.isPeriodDay,
                isPeriodStartDay: day.isPeriodStartDay,
                isPeriodEndDay: day.isPeriodEndDay,
                selectedFlow: day.flowWeight.index.toString(),
                selectedSymptoms: day.symptomList?.symptoms ?? [],
                selectedMoods: day.moodList?.moods ?? [],
                notes: day.note ?? '',
              ));
              return;
            }
            //if not in the present cycle, but in a cycle
            //emit state to load day from history
            emit(PeriodDayEntryInHistoricalCycleState(
              date: day.date,
              isPeriodDay: day.isPeriodDay,
              isPeriodStartDay: day.isPeriodStartDay,
              isPeriodEndDay: day.isPeriodEndDay,
              selectedFlow: day.flowWeight.index.toString(),
              selectedSymptoms: day.symptomList?.symptoms ?? [],
              selectedMoods: day.moodList?.moods ?? [],
              notes: day.note ?? '',
            ));

            return;
          }
          //Day entry is not a period day
          //check if day is in the future
          if (event.date.isAfter(DateTime.now())) {
            //ToDo: check if event.date is in the present cycle,
            //if not emit state to load day from the predicted cycle table
            emit(FutureDayEntryOutOfCycleState(
                date: event.date,
                isPeriodDay: day.isPeriodDay,
                selectedSymptoms: day.symptomList?.symptoms ?? [],
                selectedMoods: day.moodList?.moods ?? [],
                notes: day.note ?? ''));
            return;
          }
          //Day entry is in the past
          //Check if part of cycle
          if (isInPresentCycle == true) {
            emit(DayEntryInPresentCycleState(
              date: day.date,
              isPeriodDay: day.isPeriodDay,
              selectedSymptoms: day.symptomList?.symptoms ?? [],
              selectedMoods: day.moodList?.moods ?? [],
              notes: day.note ?? '',
            ));
          }
          emit(DayEntryInHistoricalCycleState(
            date: day.date,
            isPeriodDay: day.isPeriodDay,
            selectedSymptoms: day.symptomList?.symptoms ?? [],
            selectedMoods: day.moodList?.moods ?? [],
            notes: day.note ?? '',
          ));
          return;
        } else {
          if (isInPresentCycle == true) {
            emit(DayEntryInPresentCycleState(
              date: event.date,
              isPeriodDay: false,
              selectedSymptoms: [],
              selectedMoods: [],
              notes: '',
            ));
            return;
          }
          emit(PastDayEntryOutOfCycleState(
            date: event.date,
            isPeriodDay: false,
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
      final currentState = state;
      if (currentState is PeriodDayEntryOngoingPeriodState) {
        final s = state as PeriodDayEntryOngoingPeriodState;
        emit(PeriodDayEntryOngoingPeriodState(
          date: s.date,
          isPeriodDay: s.isPeriodDay,
          isPeriodEndDay: s.isPeriodEndDay,
          isPeriodStartDay: s.isPeriodStartDay,
          selectedFlow: event.flow,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
      if (state is PeriodDayEntryInHistoricalCycleState) {
        final s = state as PeriodDayEntryInHistoricalCycleState;
        emit(PeriodDayEntryInHistoricalCycleState(
          date: s.date,
          isPeriodDay: s.isPeriodDay,
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
      final currentState = state;
      if (currentState is DayEntryLoadedState) {
        final s = state as DayEntryLoadedState;
        emit(DayEntryLoadedState(
          date: s.date,
          isPeriodDay: s.isPeriodDay,
          selectedSymptoms: event.symptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }

      if (currentState is PeriodDayEntryOngoingPeriodState) {
        final s = state as PeriodDayEntryOngoingPeriodState;
        emit(PeriodDayEntryOngoingPeriodState(
          date: s.date,
          isPeriodDay: s.isPeriodDay,
          isPeriodEndDay: s.isPeriodEndDay,
          isPeriodStartDay: s.isPeriodStartDay,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: event.symptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
      if (state is PeriodDayEntryInHistoricalCycleState) {
        final s = state as PeriodDayEntryInHistoricalCycleState;
        emit(PeriodDayEntryInHistoricalCycleState(
          date: s.date,
          isPeriodDay: s.isPeriodDay,
          isPeriodEndDay: s.isPeriodEndDay,
          isPeriodStartDay: s.isPeriodStartDay,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: event.symptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }
    });

    on<MoodsChanged>((event, emit) {
      final currentState = state;
      if (currentState is PeriodDayEntryOngoingPeriodState) {
        final s = state as PeriodDayEntryOngoingPeriodState;
        emit(PeriodDayEntryOngoingPeriodState(
          date: s.date,
          isPeriodDay: s.isPeriodDay,
          isPeriodEndDay: s.isPeriodEndDay,
          isPeriodStartDay: s.isPeriodStartDay,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: event.moods,
          notes: s.notes,
        ));
      }
      if (state is PeriodDayEntryInHistoricalCycleState) {
        final s = state as PeriodDayEntryInHistoricalCycleState;
        emit(PeriodDayEntryInHistoricalCycleState(
          date: s.date,
          isPeriodDay: s.isPeriodDay,
          isPeriodEndDay: s.isPeriodEndDay,
          isPeriodStartDay: s.isPeriodStartDay,
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
          isPeriodDay: s.isPeriodDay,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: event.moods,
          notes: s.notes,
        ));
      }
    });

    on<NotesChanged>((event, emit) {
      final currentState = state;
      if (currentState is PeriodDayEntryOngoingPeriodState) {
        final s = state as PeriodDayEntryOngoingPeriodState;
        emit(PeriodDayEntryOngoingPeriodState(
          date: s.date,
          isPeriodDay: s.isPeriodDay,
          isPeriodEndDay: s.isPeriodEndDay,
          isPeriodStartDay: s.isPeriodStartDay,
          selectedFlow: s.selectedFlow,
          selectedSymptoms: s.selectedSymptoms,
          selectedMoods: s.selectedMoods,
          notes: event.notes,
        ));
      }
      if (state is PeriodDayEntryInHistoricalCycleState) {
        final s = state as PeriodDayEntryInHistoricalCycleState;
        emit(PeriodDayEntryInHistoricalCycleState(
          date: s.date,
          isPeriodDay: s.isPeriodDay,
          isPeriodEndDay: s.isPeriodEndDay,
          isPeriodStartDay: s.isPeriodStartDay,
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
          isPeriodDay: s.isPeriodDay,
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
            isPeriodDay: s.isPeriodDay,
            symptomList: SymptomList(symptoms: s.selectedSymptoms),
            moodList: MoodList(moods: s.selectedMoods),
            note: s.notes));
      }
    });
  }
}
