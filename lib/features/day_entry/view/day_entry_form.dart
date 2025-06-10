import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/common/utils.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/features/cycle_tracker/bloc/cycle_tracker_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_event.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_state.dart';
import 'package:mina_app/data/model/symptom_list.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_bloc.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_event.dart';
import 'package:mina_app/features/period_picker/period_day_picker_view.dart';
import 'package:provider/provider.dart';

class DayEntryForm extends StatefulWidget {
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
  State<DayEntryForm> createState() => _DayEntryFormState();
}

class _DayEntryFormState extends State<DayEntryForm> {
  late DateTime focusedDay;
  late TextEditingController notesController;
  late GlobalKey<FormState> formKey;
  late Cycle? presentCycle;
  var focusedDayCycle;

  @override
  void initState() {
    super.initState();
    focusedDay = widget.focusedDay;
    notesController = widget.notesController;
    formKey = widget.formKey;
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
                        context, focusedDay, state.isPeriodStartDay)
                  ] else ...[
                    _periodDayEndButton(
                        context, focusedDay, state.isPeriodEndDay)
                  ],
                  _periodStatusWidget(context, state, focusedDay)
                ],
                if (state is PeriodDayEntryInHistoricalCycleState) ...[
                  if (state.isPeriodStartDay) ...[
                    _periodDayStartButton(
                        context, focusedDay, state.isPeriodStartDay)
                  ],
                  if (state.isPeriodEndDay) ...[
                    _periodDayEndButton(
                        context, focusedDay, state.isPeriodEndDay)
                  ],
                  _periodStatusWidget(context, state, focusedDay)
                ],
                if (state is DayEntryInHistoricalCycleState) ...[
                  _cycleDayStats(focusedDay, presentCycle, isFutureDay: false),
                ],
                if (state is DayEntryInPresentCycleState) ...[
                  _periodDayStartButton(context, focusedDay, false),
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
                          .add(DayEntryInsertOrUpdate());
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
          ButtonSegment(value: "0", label: Text("None")),
          ButtonSegment(value: "1", label: Text("Light")),
          ButtonSegment(value: "2", label: Text("Medium")),
          ButtonSegment(value: "3", label: Text("Heavy")),
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

Widget _periodDayStartButton(
    BuildContext context, DateTime focusedDay, bool isPeriodStartDay) {
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
                    create: (_) => PeriodDayPickerBloc()
                      ..add(PeriodDaysFetched(focusedDay)),
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

Widget _periodDayEndButton(
    BuildContext context, DateTime focusedDay, bool isPeriodEndDay) {
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
                  create: (_) =>
                      PeriodDayPickerBloc()..add(PeriodDaysFetched(focusedDay)),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Period ends today"),
          const SizedBox(width: 8),
          Icon(isPeriodEndDay ? Icons.check_circle : Icons.circle_outlined),
        ],
      ));
}

class DayEntryInCycleView extends StatelessWidget {
  final DateTime focusedDay;
  final Cycle presentCycle;
  final DayEntryBlocState dayBlocState;
  final CycleTrackerCycleFetched cycleState;

  const DayEntryInCycleView({
    super.key,
    required this.focusedDay,
    required this.presentCycle,
    required this.dayBlocState,
    required this.cycleState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //ToDo check if the current cycle is in the predicted cycle table
      if (presentCycle!.isInCycle(focusedDay)) ...[
        // is day within the present cycle?

        if (focusedDay.isAfter(presentCycle!.startDate!)) ...[
          // is day after presentCycle.PeriodstartDay?

          if (focusedDay.isAfter(presentCycle!.periodEndDate!)) ...[
            // is day after presentCycle.PeriodEndDay?

            if (focusedDay.isAfter(DateTime.now())) ...[
              // is day in the future?
              //only display predicted values
              _cycleDayStats(focusedDay,
                  context.read<CycleTrackerBloc>().state.presentCycle,
                  isFutureDay: true)
            ] else ...[
              //day is part of global cycle that is currenly not complete.
              //ask user if another period has started
              if (dayBlocState is DayEntryLoadedState) ...[
                _periodDayStartButton(context, focusedDay, false),
                _cycleDayStats(focusedDay,
                    context.read<CycleTrackerBloc>().state.presentCycle,
                    isFutureDay: false)
              ]
            ],
          ] else ...[
            //is day in the future?
            if (focusedDay.isAfter(DateTime.now())) ...[
              //period has not ended yet.
              //Day is in future only display predicted values
              _cycleDayStats(focusedDay,
                  context.read<CycleTrackerBloc>().state.presentCycle,
                  isFutureDay: true),
            ] else ...[
              if (dayBlocState is PeriodDayEntryLoadedState) ...[
                _periodDayEndButton(context, focusedDay,
                    (dayBlocState as PeriodDayEntryLoadedState).isPeriodEndDay),
                _periodStatusWidget(context,
                    (dayBlocState as PeriodDayEntryLoadedState), focusedDay),
                _cycleDayStats(focusedDay,
                    context.read<CycleTrackerBloc>().state.presentCycle,
                    isFutureDay: false),
              ]
            ]
          ]
        ] else ...[
          //day is a period start day
          if (dayBlocState is PeriodDayEntryLoadedState)
            _periodDayStartButton(context, focusedDay,
                (dayBlocState as PeriodDayEntryLoadedState).isPeriodStartDay),
        ]
      ] else ...[
        //day does not fall within the scope of the present cycle
        //but is within a cycle
        //it must be a historical cycle
        if (context.read<CycleTrackerBloc>().state is CycleTrackerCycleFetched)
          //if the cycle exists
          ...[
          if (focusedDay.isAfter(cycleState.focusedDayCycle.startDate!))
            //is the focused day after the start of the cycle?
            ...[
            if (focusedDay
                .isAfter(cycleState.focusedDayCycle.periodEndDate!)) ...[
              //is the focused day after the end of the of a period endDate
              _cycleDayStats(focusedDay, cycleState.focusedDayCycle,
                  isFutureDay: false),
            ] else ...[
              //historical day is either an PeriodEndDate or a day after periodStartDate
              if (Utils()
                  .normalizedDate(cycleState.focusedDayCycle.periodEndDate!)
                  .isAtSameMomentAs(Utils().normalizedDate(focusedDay))) ...[
                //day is a period end day
                if (dayBlocState is PeriodDayEntryLoadedState) ...[
                  _periodDayEndButton(
                      context,
                      focusedDay,
                      (dayBlocState as PeriodDayEntryLoadedState)
                          .isPeriodEndDay),
                  _periodStatusWidget(context,
                      (dayBlocState as PeriodDayEntryLoadedState), focusedDay),
                  _cycleDayStats(focusedDay, cycleState.focusedDayCycle,
                      isFutureDay: false),
                ]
              ] else ...[
                //focused day is a periodDay after the periodStartDate
                _periodStatusWidget(context,
                    dayBlocState as PeriodDayEntryLoadedState, focusedDay),
                _cycleDayStats(focusedDay, cycleState.focusedDayCycle,
                    isFutureDay: false),
              ]
            ]
          ] else ...[
            //day is a Period startDay
            if (dayBlocState is PeriodDayEntryLoadedState) ...[
              _periodDayStartButton(context, focusedDay,
                  (dayBlocState as PeriodDayEntryLoadedState).isPeriodStartDay),
              _periodStatusWidget(context,
                  (dayBlocState as PeriodDayEntryLoadedState), focusedDay)
            ]
          ]
        ]
      ],
    ]);
  }
}

class DayEntryOutOfCycleView extends StatelessWidget {
  final DateTime focusedDay;
  final Cycle? presentCycle;

  const DayEntryOutOfCycleView({
    super.key,
    required this.focusedDay,
    required this.presentCycle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (!presentCycle!.startDate!.isAtSameMomentAs(DateTime(0, 0, 0))) ...[
        //Global cycle exists
        if (focusedDay.isBefore(presentCycle!.startDate!)) ...[
          //focused day is historically outside of any cycle
          //show no period picker view.
          //display as non-fertile day
          const Text("Non-Fertile day"),
        ] else ...[
          //focused day is futuristically outside of any cycle
          //show no period picker view.
          //show only predictions
          _cycleDayStats(focusedDay, null, isFutureDay: true),
        ]
      ] else ...[
        //Present cycle does not exist
        //hence no cycle has been recorded.
        //invite user to start a new cycle.
        _periodDayStartButton(context, focusedDay, false)
      ],
    ]);
  }
}
