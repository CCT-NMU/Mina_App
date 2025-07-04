import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/common/utils.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/features/cycle_tracker/bloc/cycle_tracker_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_events.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_event.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_state.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:mina_app/data/model/symptom_list.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_bloc.dart';
import 'package:mina_app/features/period_picker/period_day_picker_view.dart';
import 'package:provider/provider.dart';

class DayEntryForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final DateTime focusedDay;
  final TextEditingController notesController;
  final String userId;

  const DayEntryForm(
      {super.key,
      required this.formKey,
      required this.focusedDay,
      required this.notesController,
      required this.userId});

  @override
  State<DayEntryForm> createState() => _DayEntryFormState();
}

class _DayEntryFormState extends State<DayEntryForm> {
  late DateTime focusedDay;
  late TextEditingController notesController;
  late GlobalKey<FormState> formKey;
  late Cycle? presentCycle;
  late String userId;
  var focusedDayCycle;

  @override
  void initState() {
    super.initState();
    focusedDay = widget.focusedDay;
    notesController = widget.notesController;
    formKey = widget.formKey;
    userId = widget.userId;
    presentCycle = context.read<CycleTrackerBloc>().state.presentCycle;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayEntryBloc, DayEntryBlocState>(
      builder: (context, state) {
        if (state is DayEntryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        // set the notes for the day or period day.
        if (state is DayEntryLoadedState ||
            state is PeriodDayEntryLoadedState) {
          notesController.text = (state as dynamic).notes;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state is PeriodDayEntryOngoingPeriodState) ...[
                  if (state.isPeriodStartDay) ...[
                    _periodDayStartButton(
                        context, focusedDay, state.isPeriodStartDay, userId),
                  ],
                  if (state.isPeriodEndDay ||
                      state.isPeriodDay && !state.isPeriodStartDay) ...[
                    _periodDayEndButton(
                        context, focusedDay, state.isPeriodEndDay, userId)
                  ],
                  _periodStatusWidget(context, state, focusedDay)
                ],
                if (state is PeriodDayEntryInHistoricalCycleState) ...[
                  if (state.isPeriodStartDay) ...[
                    _periodDayStartButton(
                        context, focusedDay, state.isPeriodStartDay, userId)
                  ],
                  if (state.isPeriodEndDay) ...[
                    _periodDayEndButton(
                        context, focusedDay, state.isPeriodEndDay, userId)
                  ],
                  _periodStatusWidget(context, state, focusedDay)
                ],
                if (state is DayEntryInHistoricalCycleState) ...[
                  _cycleDayStats(focusedDay, presentCycle, isFutureDay: false),
                ],
                if (state is DayEntryInPresentCycleState) ...[
                  _periodDayStartButton(context, focusedDay, false, userId),
                  _cycleDayStats(focusedDay, presentCycle, isFutureDay: false),
                ],
                if (state is PastDayEntryOutOfCycleState) ...[
                  _cycleDayStats(focusedDay, presentCycle, isFutureDay: false),
                ],
                if (state is FutureDayEntryOutOfCycleState) ...[
                  _cycleDayStats(focusedDay, presentCycle, isFutureDay: true)
                ],

                const SizedBox(height: 16),

                // Symptoms
                const Text("Symptoms",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
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
                const SizedBox(height: 16),

                // Moods
                const Text("Moods",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
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
                        context
                            .read<DayEntryBloc>()
                            .add(MoodsChanged(newMoods));
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Notes
                const Text("Notes",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),

                TextFormField(
                  controller: notesController,
                  minLines: 2,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add any notes...",
                  ),
                  onChanged: (value) {
                    context.read<DayEntryBloc>().add(NotesChanged(value));
                  },
                ),
                const SizedBox(height: 24),

                // Save Button
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: () {
                      context
                          .read<DayEntryBloc>()
                          .add(DayEntryInsertOrUpdate(widget.userId));

                      Navigator.pop(context, true);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Save Entry"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

_periodStatusWidget(BuildContext context, PeriodDayEntryLoadedState state,
    DateTime focusedDay) {
  return Column(
    children: [
      const Text("Flow Intensity",
          style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      SegmentedButton<String>(
        segments: const [
          ButtonSegment(value: "0", label: Text("1")),
          ButtonSegment(value: "1", label: Text("2")),
          ButtonSegment(value: "2", label: Text("3")),
          ButtonSegment(value: "3", label: Text("4")),
        ],
        selected: state.selectedFlow != null ? {state.selectedFlow!} : {"0"},
        emptySelectionAllowed: true,
        onSelectionChanged: (Set<String> newSelection) {
          context.read<DayEntryBloc>().add(
                FlowChanged(
                    newSelection.isNotEmpty ? newSelection.first : null),
              );
        },
      ),
    ],
  );
}

Widget _cycleDayStats(DateTime focusedDay, Cycle? focusedCycle,
    {required bool isFutureDay}) {
  return isFutureDay
      ? Column(
          children: [
            //implement Cycle Predict Table fetch here
            //perdicted Period Day/Fertile Day/ Ovulation Day/ Non-Fertile Day
          ],
        )
      : Column(
          //This day exists in a cycle so call data

          children: [
// no.# day of period
// no.# day of cycle
// no.# days until fertile
// no.# days until ovulation
          ],
        );
}

Widget _periodDayStartButton(BuildContext context, DateTime focusedDay,
    bool isPeriodStartDay, String userId) {
  return TextButton(
      onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<DayEntryBloc>(),
                  ),
                  BlocProvider(
                    create: (_) => PeriodDayPickerBloc(
                        Provider.of<DayEntryRepository>(context, listen: false))
                      ..add(PeriodDaysFetched(focusedDay, userId)),
                  ),
                  BlocProvider(
                      create: (_) =>
                          OnboardingBloc()..add(OnboardingCompleted())),
                ],
                child: PeriodDayPickerView(focusedDay: focusedDay),
              ),
            ),
          ),
      child: Row(
        children: [
          Text('period starts today'),
          const SizedBox(width: 8),
          Icon(isPeriodStartDay ? Icons.check_circle : Icons.circle_outlined),
        ],
      ));
}

Widget _periodDayEndButton(BuildContext context, DateTime focusedDay,
    bool isPeriodEndDay, String userId) {
  return TextButton(
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
                  create: (_) => PeriodDayPickerBloc(
                      Provider.of<DayEntryRepository>(context, listen: false))
                    ..add(PeriodDaysFetched(focusedDay, userId)),
                ),
                BlocProvider(
                    create: (_) =>
                        OnboardingBloc()..add(OnboardingCompleted())),
              ],
              child: PeriodDayPickerView(focusedDay: focusedDay),
            ),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("period ends today"),
          const SizedBox(width: 8),
          Icon(isPeriodEndDay ? Icons.check_circle : Icons.circle_outlined),
        ],
      ));
}
