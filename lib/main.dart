import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/data/repositories/user_repository.dart';
import 'package:mina_app/features/cycle_tracker/bloc/cycle_tracker_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_events.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_states.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_bloc.dart';
import 'package:mina_app/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mina_app/features/onboarding/view/welcome.dart';
import 'package:mina_app/features/period_picker/last_period_start_date_view.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_bloc.dart';
import 'package:mina_app/features/period_picker/period_day_picker_view.dart';
import 'package:mina_app/services/auth_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/auth/bloc/auth_bloc.dart';
import 'package:mina_app/features/auth/view/login_view.dart';
import 'package:mina_app/features/dashboard/view/dashboard_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'package:mina_app/services/fake_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  // TODO: (refactor to be more secure)

  await Supabase.initialize(
      url: 'https://lljkykkolucqyudnicaq.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxsamt5a2tvbHVjcXl1ZG5pY2FxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA3NTU0MzYsImV4cCI6MjA2NjMzMTQzNn0.eRh0tgaAFJhxadh1clwaOVunGylz2uZUTrLgYiLKF0Q');

  // Initialize notifications
  // await NotificationService().initialize();

  runApp(MinaApp());
}

class MinaApp extends StatelessWidget {
  const MinaApp({super.key});

/*   Future<bool> userHasName() async {
    final name = await UserRepository.instance.getUserSetting('name',);
    return name != null && name.isNotEmpty;
  } */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: true,
        home: MultiBlocProvider(providers: [
          BlocProvider<CycleTrackerBloc>(
            create: (context) => CycleTrackerBloc(),
          ),
          BlocProvider<DashboardBloc>(
            create: (context) =>
                DashboardBloc()..add(LoadDashboard(DateTime.now())),
          ),
          BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc()..add(OnboardingCompleted()),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          )
        ], child: AuthWrapper()));
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
        } else {
          return const LoginView();
        }
      },
    );
  }
}
