import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/data/model/symptom_list.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/features/cycle_tracker/bloc/cycle_tracker_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_events.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_event.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_state.dart';
import 'package:mina_app/features/day_entry/view/day_entry_form.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_bloc.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_event.dart';
import 'package:mina_app/features/period_picker/period_day_picker_view.dart';

class DayEntryView extends StatefulWidget {
  const DayEntryView({super.key, required this.focusedDay, this.existingDay});
  final DateTime focusedDay;
  final Day? existingDay; // Optional existing day entry

  @override
  State<DayEntryView> createState() => _DayEntryViewState();
}

class _DayEntryViewState extends State<DayEntryView> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

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
        body: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<DayEntryBloc>()),
            BlocProvider.value(value: context.read<CycleTrackerBloc>()),
          ],
          child: BlocBuilder<DayEntryBloc, DayEntryBlocState>(
            builder: (context, state) {
              if (state is DayEntryLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is DayEntryLoadedState ||
                  state is PeriodDayEntryLoadedState) {
                if (state is DayEntryLoadedState) {
                  _notesController.text = state.notes;
                } else if (state is PeriodDayEntryLoadedState) {
                  _notesController.text = state.notes ?? '';
                }

                return DayEntryForm(
                  formKey: _formKey,
                  notesController: _notesController,
                  focusedDay: widget.focusedDay,
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}
