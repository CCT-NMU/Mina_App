import 'package:flutter/material.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_bloc.dart';
import 'package:mina_app/features/period_picker/period_day_picker_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/onboarding/bloc/onboarding_bloc.dart';

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
      body: Center(
        child: Column(
          children: [
            Text('What is your name'),
            TextField(
              controller: nameController,
            ),
            Row(children: [
              TextButton(
                onPressed: () {
                  context.read<OnboardingBloc>().add(
                        OnboardingNameSubmitted(name: nameController.text),
                      );
                  final onboardingBloc = context.read<OnboardingBloc>();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(value: onboardingBloc),
                                BlocProvider(
                                  create: (context) => PeriodDayPickerBloc(),
                                )
                              ],
                              child: PeriodDayPickerView(
                                  focusedDay: DateTime.now()),
                            )),
                  ); // Replace '/nextPage' with your actual route
                },
                child: Text("Save"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              )
            ])
          ],
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
