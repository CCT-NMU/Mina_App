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
import 'package:mina_app/services/auth_service/platform/supabase_auth_service.dart';

class DayEntryBloc extends Bloc<DayEntryBlocEvent, DayEntryBlocState> {
  DayEntryRepository dayEntryRepository;
  CycleRepository cycleRepository;
  DayEntryBloc(
      {required this.dayEntryRepository, required this.cycleRepository})
      : super(const DayEntryInitialState()) {
    String userId = SupabaseAuthService().currentUserId!;

    on<DayEntryFetch>((event, emit) async {
      emit(const DayEntryLoadingState());
      try {
        //find if day exists
        print(
            'DayEntryBloc: Fetching day entry for date: ${event.date} and userId: $userId');
        var day =
            await dayEntryRepository.getDayEntry(event.date, event.userId);
        //find if day is in present cycle
        print(
            'DayEntryBloc: Day entry for date: ${event.date} and userId: $userId found: ${day != null}');
        var presentCycle = await cycleRepository.getPresentCycle(userId);
        print(
            'DayEntryBloc: Present cycle for userId: $userId found: ${presentCycle != null}');
        bool isInPresentCycle = false;
        if (presentCycle != null) {
          isInPresentCycle =
              presentCycle.isInCycle(Utils().normalizedDate(event.date));
        }

        if (day != null) {
          if (day is PeriodDay) {
            //check if day is in the present cycle
            print('DayEntryBloc: Day is a PeriodDay ');
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
          print('DayEntryBloc: Day is a not a Normal Day');
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
          //Check if part of present cycle
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
          print(isInPresentCycle
              ? 'DayEntryBloc: New Day entry Day is in the present cycle'
              : 'DayEntryBloc: New Day entry Day is not in the present cycle');
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
      var currentState = state;
      if (currentState is PeriodDayEntryOngoingPeriodState) {
        var s = state as PeriodDayEntryOngoingPeriodState;
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
        var s = state as PeriodDayEntryInHistoricalCycleState;
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
      var currentState = state;
      if (currentState is DayEntryLoadedState) {
        var s = state as DayEntryLoadedState;
        emit(DayEntryLoadedState(
          date: s.date,
          isPeriodDay: s.isPeriodDay,
          selectedSymptoms: event.symptoms,
          selectedMoods: s.selectedMoods,
          notes: s.notes,
        ));
      }

      if (currentState is PeriodDayEntryOngoingPeriodState) {
        var s = state as PeriodDayEntryOngoingPeriodState;
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
        var s = state as PeriodDayEntryInHistoricalCycleState;
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
      var currentState = state;
      if (currentState is PeriodDayEntryOngoingPeriodState) {
        var s = state as PeriodDayEntryOngoingPeriodState;
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
        var s = state as PeriodDayEntryInHistoricalCycleState;
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
        var s = state as DayEntryLoadedState;
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
      var currentState = state;
      if (currentState is PeriodDayEntryOngoingPeriodState) {
        var s = state as PeriodDayEntryOngoingPeriodState;
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
        var s = state as PeriodDayEntryInHistoricalCycleState;
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
        var s = state as DayEntryLoadedState;
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
        var s = state as PeriodDayEntryLoadedState;
        dayEntryRepository.insertPeriodDayEntry(
          PeriodDay(
              date: s.date,
              flowWeight:
                  PeriodDay.flowWeightValues[int.parse(s.selectedFlow!)],
              symptomList: SymptomList(symptoms: s.selectedSymptoms),
              moodList: MoodList(moods: s.selectedMoods),
              isPeriodStartDay: s.isPeriodStartDay,
              isPeriodEndDay: s.isPeriodEndDay,
              note: s.notes),
          event.userId,
        );
        return;
      }
      if (state is DayEntryLoadedState) {
        var s = state as DayEntryLoadedState;
        dayEntryRepository.insertDayEntry(
            Day(
                date: s.date,
                isPeriodDay: s.isPeriodDay,
                symptomList: SymptomList(symptoms: s.selectedSymptoms),
                moodList: MoodList(moods: s.selectedMoods),
                note: s.notes),
            event.userId);
      }
    });
  }

  @override
  void onTransition(
      Transition<DayEntryBlocEvent, DayEntryBlocState> transition) {
    super.onTransition(transition);

    print('Transition: ${transition.event} '
        'from ${transition.currentState}'
        'to ${transition.nextState} ');
  }
}
