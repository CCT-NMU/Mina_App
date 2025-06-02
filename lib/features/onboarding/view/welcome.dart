import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:mina_app/features/onboarding/view/name_capture.dart';
import 'package:mina_app/features/onboarding/bloc/onboarding_bloc.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: null, child: Text("Login")),
            TextButton(
                onPressed: () {
                  final onboardingBloc = context.read<OnboardingBloc>();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                              value: onboardingBloc,
                              child: const NameCapture(),
                            )),
                  );
                },
                child: Text("Continue")),
          ],
        ),
        body: Center(
          child: Text("Welcome"),
        ));
  }
}
