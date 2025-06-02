import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/cycle_tracker/bloc/cycle_tracker_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_event.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_state.dart';
import 'package:mina_app/data/model/symptom_list.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_bloc.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_event.dart';
import 'package:mina_app/features/period_picker/period_day_picker_view.dart';

class DayEntryForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final DateTime focusedDay;
  final TextEditingController notesController;

  const DayEntryForm({
    super.key,
    required this.formKey,
    required this.focusedDay,
    required this.notesController,
  });

  @override
  Widget build(BuildContext context) {
    final cycleTrackerBloc = context.read<CycleTrackerBloc>();
    final cycleTrackerstate = cycleTrackerBloc.state;
    cycleTrackerBloc.add(FetchCurrentCycle());
    return BlocBuilder<DayEntryBloc, DayEntryBlocState>(
      builder: (context, state) {
        if (state is DayEntryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DayEntryLoadedState) {
          notesController.text = state.notes;
        }
        if (state is PeriodDayEntryLoadedState) {
          notesController.text = state.notes ?? '';
        }
        return Form(
          key: formKey,
          child: Column(
            children: [
              // Removed cycleTrackerBloc.add(FetchCurrentCycle as CycleTrackerEvent),
              if (cycleTrackerstate is CycleTrackerCurrent)
                if (cycleTrackerstate.currentCycle.startDate
                    .isBefore(focusedDay))
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<DayEntryBloc>(),
                              ),
                              BlocProvider(
                                create: (_) => PeriodDayPickerBloc()
                                  ..add(PeriodDaysFetched(focusedDay)),
                              )
                            ],
                            child: PeriodDayPickerView(focusedDay: focusedDay),
                          ),
                        ),
                      );
                    },
                    child: Row(children: [
                      Text("Period ends today"),
                      Icon(focusedDay == cycleTrackerstate.currentCycle.endDate
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off),
                    ]),
                  ),
              // Flow Intensity
              if (state is PeriodDayEntryLoadedState)
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: "0", label: Text("None")),
                    ButtonSegment(value: "1", label: Text("Light")),
                    ButtonSegment(value: "2", label: Text("Medium")),
                    ButtonSegment(value: "3", label: Text("Heavy")),
                  ],
                  selected: state is PeriodDayEntryLoadedState
                      ? {state.selectedFlow!}
                      : {},
                  emptySelectionAllowed: true,
                  onSelectionChanged: state is PeriodDayEntryLoadedState
                      ? (Set<String> newSelection) {
                          context.read<DayEntryBloc>().add(
                                FlowChanged(newSelection.isNotEmpty
                                    ? newSelection.first
                                    : null),
                              );
                        }
                      : null,
                ),
              // Symptoms
              Wrap(
                children: SymptomList.predefinedSymptoms.map((symptom) {
                  List<String> selectedSymptoms = [];
                  if (state is PeriodDayEntryLoadedState) {
                    selectedSymptoms = state.selectedSymptoms;
                  }
                  if (state is DayEntryLoadedState) {
                    selectedSymptoms = state.selectedSymptoms;
                  }
                  final isSelected = selectedSymptoms.contains(symptom);
                  return FilterChip(
                    label: Text(symptom),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      List<String> newSymptoms =
                          List<String>.from(selectedSymptoms);
                      if (selected) {
                        newSymptoms.add(symptom);
                      } else {
                        newSymptoms.remove(symptom);
                      }
                      context
                          .read<DayEntryBloc>()
                          .add(SymptomsChanged(newSymptoms));
                    },
                  );
                }).toList(),
              ),
              // Moods
              Wrap(
                children: MoodList.predefinedMoods.map((mood) {
                  List<String> selectedMoods = [];
                  if (state is PeriodDayEntryLoadedState) {
                    selectedMoods = state.selectedMoods;
                  } else if (state is DayEntryLoadedState) {
                    selectedMoods = state.selectedMoods;
                  }
                  final isSelected = selectedMoods.contains(mood);
                  return FilterChip(
                    label: Text(mood),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      final newMoods = List<String>.from(selectedMoods);
                      if (selected) {
                        newMoods.add(mood);
                      } else {
                        newMoods.remove(mood);
                      }
                      context.read<DayEntryBloc>().add(MoodsChanged(newMoods));
                    },
                  );
                }).toList(),
              ),
              // Notes
              TextFormField(
                controller: notesController,
                onChanged: (value) {
                  context.read<DayEntryBloc>().add(NotesChanged(value));
                },
              ),
              // Save Button
              FilledButton.icon(
                onPressed: () {
                  // Save logic: use state values
                },
                icon: const Icon(Icons.save),
                label: const Text("Save Entry"),
              ),
            ],
          ),
        );
      },
    );
  }
}
