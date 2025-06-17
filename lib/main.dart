import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/data/repositories/user_repository.dart';
import 'package:mina_app/features/cycle_tracker/bloc/cycle_tracker_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_bloc.dart';
import 'package:mina_app/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mina_app/features/onboarding/view/welcome.dart';
import 'package:mina_app/features/period_picker/last_period_start_date_view.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_bloc.dart';
import 'package:mina_app/features/period_picker/period_day_picker_view.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/auth/bloc/auth_bloc.dart';
import 'package:mina_app/features/auth/view/login_view.dart';
import 'package:mina_app/features/dashboard/view/dashboard_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  // TODO: (refactor to be more secure)
  await Supabase.initialize(
    url: 'https://qvlfvktdzzpcuximbdic.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF2bGZ2a3RkenpwY3V4aW1iZGljIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg0MjQ1OTcsImV4cCI6MjA2NDAwMDU5N30.gJbrV1oFuczqPUhs9RMn2ofc6BP1gYGml97jDEfFwzg',
  );
  // Initialize notifications
  // await NotificationService().initialize();

  runApp(const MinaApp());
}

class MinaApp extends StatelessWidget {
  const MinaApp({super.key});

  Future<bool> userHasName() async {
    final name = await UserRepository.instance.getUserSetting('name');
    return name != null && name.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper().clearAllData();
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: true,
      home: FutureBuilder<bool>(
        future: userHasName(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!) {
            return MultiBlocProvider(providers: [
              BlocProvider<CycleTrackerBloc>(
                create: (context) => CycleTrackerBloc(),
              ),
              BlocProvider<DashboardBloc>(
                create: (context) => DashboardBloc(),
              ),
              BlocProvider<OnboardingBloc>(
                create: (_) => OnboardingBloc()..add(OnboardingCompleted()),
              ),
            ], child: AuthWrapper());
          } else {
            return MultiBlocProvider(providers: [
              BlocProvider<CycleTrackerBloc>(
                create: (context) => CycleTrackerBloc(),
              ),
              BlocProvider<OnboardingBloc>(
                create: (_) => OnboardingBloc()..add(OnboardingStarted()),
              ),
              BlocProvider(create: (context) => AuthBloc()..add(AuthStarted())),
              BlocProvider<PeriodDayPickerBloc>(
                  create: (_) => PeriodDayPickerBloc()
                    ..add(PeriodDaysFetched(DateTime.now()))),
            ], child: const AuthWrapper());
          }
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AuthInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthAuthenticated) {
          return const DashboardView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
