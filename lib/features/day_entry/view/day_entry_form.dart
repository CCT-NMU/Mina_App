import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_event.dart';
import 'package:mina_app/features/period/bloc/period_day_picker_bloc.dart';
import 'package:mina_app/features/period/bloc/period_day_picker_event.dart';
import 'package:mina_app/features/period/period_day_picker_view.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/model/symptom_list.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';

class DayEntryForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String? selectedFlow;
  final bool isPeriodDaySelected;
  final List<String> selectedSymptoms;
  final List<String> selectedMoods;
  final TextEditingController notesController;
  final DateTime focusedDay;

  const DayEntryForm({
    super.key,
    required this.formKey,
    required this.selectedFlow,
    required this.isPeriodDaySelected,
    required this.selectedSymptoms,
    required this.selectedMoods,
    required this.notesController,
    required this.focusedDay,
  });

  @override
  State<DayEntryForm> createState() => _DayEntryFormState();
}

class _DayEntryFormState extends State<DayEntryForm> {
  late String? _selectedFlow;
  late bool _isPeriodDaySelected;
  late List<String> _selectedSymptoms;
  late List<String> _selectedMoods;

  @override
  void initState() {
    super.initState();
    _selectedFlow = widget.selectedFlow;
    _isPeriodDaySelected = widget.isPeriodDaySelected;
    _selectedSymptoms = List<String>.from(widget.selectedSymptoms);
    _selectedMoods = List<String>.from(widget.selectedMoods);
  }

  void _saveEntry() {
    if (widget.formKey.currentState!.validate()) {
      if (_isPeriodDaySelected) {
        final periodDay = PeriodDay(
          date: widget.focusedDay,
          flowWeight: _selectedFlow != null
              ? PeriodDay.flowWeightValues[int.parse(_selectedFlow!)]
              : FlowWeight.none,
          isPeriodStartDay: false,
          isPeriodEndDay: false,
          note: widget.notesController.text,
          listSymptoms: SymptomList(symptoms: _selectedSymptoms),
          listMoods: MoodList(moods: _selectedMoods),
        );
        DayEntryRepository.instance.insertPeriodDayEntry(periodDay, null);
      } else {
        DayEntryRepository.instance.deletePeriodDayEntry(widget.focusedDay);
        final day = Day(
          date: widget.focusedDay,
          isPeriodDay: _isPeriodDaySelected,
          note: widget.notesController.text,
          symptomList: SymptomList(symptoms: _selectedSymptoms),
          moodList: MoodList(moods: _selectedMoods),
        );
        DayEntryRepository.instance.insertDayEntry(day);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Entry saved successfully!")),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(55, 225, 194, 230),
            Color.fromARGB(55, 241, 188, 206)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                TextButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: context.read<DayEntryBloc>(),
                            ),
                            BlocProvider(
                              create: (_) => PeriodDayPickerBloc()
                                ..add(PeriodDaysFetched(widget.focusedDay)),
                            ),
                          ],
                          child: PeriodDayPickerView(
                              focusedDay: widget.focusedDay),
                        ),
                      ),
                    );
                    if (result == true) {
                      context
                          .read<DayEntryBloc>()
                          .add(DayEntryReloadRequest(widget.focusedDay));
                      setState(() {});
                    }
                  },
                  child: const Text("Period Day Picker"),
                )
              ]),
              //TODO: Fix Flow Intensity inactivity
              const SizedBox(height: 20),
              const Text("Flow Intensity",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: "0", label: Text("None")),
                  ButtonSegment(value: "1", label: Text("Light")),
                  ButtonSegment(value: "2", label: Text("Medium")),
                  ButtonSegment(value: "3", label: Text("Heavy")),
                ],
                selected: _selectedFlow != null ? {_selectedFlow!} : {},
                emptySelectionAllowed: true,
                onSelectionChanged: _isPeriodDaySelected
                    ? (Set<String> newSelection) {
                        setState(() {
                          _selectedFlow = newSelection.isNotEmpty
                              ? newSelection.first
                              : null;
                        });
                      }
                    : null,
              ),
              const SizedBox(height: 24),
              const Text("Symptoms",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: SymptomList.predefinedSymptoms.map((symptom) {
                  final isSelected = _selectedSymptoms.contains(symptom);
                  final symptomEmojis = {
                    'Cramps': '🤕',
                    'Headache': '🤯',
                    'Bloating': '🫃',
                    'Fatigue': '😴',
                    'Breast Tenderness': '🤱',
                    'Back Pain': '🦴',
                    'Acne': '😶‍🌫️',
                    'Nausea': '🤢',
                    'Dizziness': '😵',
                    'Food Cravings': '🍫',
                    'Insomnia': '🌙',
                    'Muscle Pain': '💪',
                  };
                  return FilterChip(
                    label: Text('${symptomEmojis[symptom] ?? ''} $symptom'),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedSymptoms.add(symptom);
                        } else {
                          _selectedSymptoms.remove(symptom);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              const Text("Moods",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: MoodList.predefinedMoods.map((mood) {
                  final isSelected = _selectedMoods.contains(mood);
                  final moodEmojis = {
                    'Happy': '😊',
                    'Sad': '😢',
                    'Irritable': '😤',
                    'Anxious': '😨',
                    'Calm': '😌',
                    'Energetic': '⚡',
                    'Tired': '😴',
                    'Emotional': '😭',
                    'Motivated': '🚀',
                    'Stressed': '😰',
                    'Relaxed': '😌',
                    'Angry': '😡',
                    'Excited': '🤩',
                    'Disappointed': '😞',
                    'Confused': '😕',
                  };
                  return FilterChip(
                    label: Text('${moodEmojis[mood] ?? ''} $mood'),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedMoods.add(mood);
                        } else {
                          _selectedMoods.remove(mood);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: widget.notesController,
                decoration: const InputDecoration(
                  labelText: "Notes",
                  hintText: "Add any additional notes here...",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Center(
                child: FilledButton.icon(
                  onPressed: _saveEntry,
                  icon: const Icon(Icons.save),
                  label: const Text("Save Entry"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
