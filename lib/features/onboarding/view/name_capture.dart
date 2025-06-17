import 'package:flutter/material.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_bloc.dart';
import 'package:mina_app/features/period_picker/period_day_picker_view.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mina_app/services/auth_service.dart';

class NameCapture extends StatefulWidget {
  const NameCapture({super.key});

  @override
  State<NameCapture> createState() => _NameCaptureState();
}

class _NameCaptureState extends State<NameCapture> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What is your name?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _onSave(context),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Save"),
                  onPressed: () => _onSave(context),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSave(BuildContext context) {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name.')),
      );
      return;
    }
    context.read<OnboardingBloc>().add(
          OnboardingNameSubmitted(name: name),
        );
    final onboardingBloc = context.read<OnboardingBloc>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: onboardingBloc),
            BlocProvider(
              create: (context) {
                final bloc = PeriodDayPickerBloc();
                //ToDo fix the onboarding auth.
                bloc.add(PeriodDaysFetched(
                    DateTime.now(), AuthService.instance.currentUser!.id));
                return bloc;
              },
            ),
            BlocProvider(
              create: (context) => DashboardBloc(
                userId: '',
              ),
            )
          ],
          child: PeriodDayPickerView(focusedDay: DateTime.now()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
