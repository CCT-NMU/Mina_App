import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/data/model/symptom_list.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_events.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_event.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_state.dart';
import 'package:mina_app/features/day_entry/view/day_entry_form.dart';
import 'package:mina_app/features/period/bloc/period_day_picker_bloc.dart';
import 'package:mina_app/features/period/bloc/period_day_picker_event.dart';
import 'package:mina_app/features/period/period_day_picker_view.dart';

class DayEntryView extends StatefulWidget {
  const DayEntryView({super.key, required this.focusedDay, this.existingDay});
  final DateTime focusedDay;
  final Day? existingDay; // Optional existing day entry

  @override
  State<DayEntryView> createState() => _DayEntryViewState();
}

class _DayEntryViewState extends State<DayEntryView> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedFlow;
  bool _isPeriodDaySelected = false; // Track if "Is Period Day" is selected
  List<String> _selectedSymptoms = [];
  List<String> _selectedMoods = [];
  TextEditingController _notesController = TextEditingController();
  bool _isPeriodStartDay = false;
  bool _isPeriodEndDay = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              // When navigating back to dashboard, trigger reload
              context
                  .read<DashboardBloc>()
                  .add(LoadDashboard(widget.focusedDay));
              Navigator.pop(context, true);
            },
          ),
          title: Text(
            "Tracking for: ${widget.focusedDay.day}/${widget.focusedDay.month}/${widget.focusedDay.year}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<DayEntryBloc, DayEntryBlocState>(
          builder: (context, state) {
            if (state is DayEntryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DayEntryLoadedState) {
              var day = state.day;
              _isPeriodDaySelected = day.isPeriodDay;
              _selectedSymptoms = day.symptomList?.symptoms ?? [];
              _selectedMoods = day.moodList?.moods ?? [];

              _selectedFlow = "0";
              _isPeriodStartDay = false;
              _isPeriodEndDay = false;

              _notesController.text = day.note ?? "";

              return DayEntryForm(
                formKey: _formKey,
                selectedFlow: _selectedFlow,
                isPeriodDaySelected: _isPeriodDaySelected,
                selectedSymptoms: _selectedSymptoms,
                selectedMoods: _selectedMoods,
                notesController: _notesController,
                focusedDay: widget.focusedDay,
              );
            }
            if (state is NewDayEntryState) {
              return DayEntryForm(
                formKey: _formKey,
                selectedFlow: _selectedFlow,
                isPeriodDaySelected: _isPeriodDaySelected,
                selectedSymptoms: _selectedSymptoms,
                selectedMoods: _selectedMoods,
                notesController: _notesController,
                focusedDay: widget.focusedDay,
              );
            }
            if (state is PeriodDayEntryLoadedState) {
              if (state is DayEntryLoadedState) {
                var periodDay = state.periodDay;
                _isPeriodDaySelected = periodDay.isPeriodDay;
                _selectedSymptoms = periodDay.symptomList?.symptoms ?? [];
                _selectedMoods = periodDay.moodList?.moods ?? [];
                if (_isPeriodDaySelected) {
                  _selectedFlow = periodDay.flowWeight.index.toString();
                  _isPeriodStartDay = periodDay.isPeriodStartDay;
                  _isPeriodEndDay = periodDay.isPeriodEndDay;
                }
                _notesController.text = periodDay.note ?? "";

                return DayEntryForm(
                  formKey: _formKey,
                  selectedFlow: _selectedFlow,
                  isPeriodDaySelected: _isPeriodDaySelected,
                  selectedSymptoms: _selectedSymptoms,
                  selectedMoods: _selectedMoods,
                  notesController: _notesController,
                  focusedDay: widget.focusedDay,
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      if (_isPeriodDaySelected) {
        final periodDay = PeriodDay(
          date: widget.focusedDay,
          flowWeight: _selectedFlow != null
              ? PeriodDay.flowWeightValues[int.parse(_selectedFlow!)]
              : FlowWeight.none,
          //TODO add validation for start and end days
          isPeriodStartDay: false,
          isPeriodEndDay: false,
          note: _notesController.text,
          listSymptoms: SymptomList(symptoms: _selectedSymptoms),
          listMoods: MoodList(moods: _selectedMoods),
        );
        DayEntryRepository.instance.insertPeriodDayEntry(periodDay, null);
      } else {
        DayEntryRepository.instance.deletePeriodDayEntry(widget.focusedDay);
        final day = Day(
          date: widget.focusedDay,
          isPeriodDay: _isPeriodDaySelected,
          note: _notesController.text,
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
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Route _createRoute(DateTime focusedDay) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FutureBuilder<Day?>(
            future: DayEntryRepository.instance.getDayEntry(focusedDay),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text('Error: ${snapshot.error}')),
                );
              }
              if (snapshot.hasData) {
                return DayEntryView(
                  focusedDay: focusedDay,
                  existingDay: snapshot.data,
                );
              }
              return DayEntryView(focusedDay: focusedDay);
            });
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
