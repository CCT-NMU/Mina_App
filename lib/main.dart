import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/data/database/connection/shared.dart' as db_connection;
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/data/repositories/note_repository.dart';
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
import 'package:mina_app/services/auth_service/platform/supabase_auth_service.dart';
import 'package:provider/provider.dart';
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
      url: 'https://cduomqsrmiiplojuchsv.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNkdW9tcXNybWlpcGxvanVjaHN2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA3MTMwNTYsImV4cCI6MjA2NjI4OTA1Nn0.vdrCoqm2onfdj04mcfV12Ovu7fPlwXuC4IB-qqCBeWQ');

  // Initialize notifications
  // await NotificationService().initialize();

  runApp(Provider<AppDatabase>(
    create: (context) => db_connection.constructDb(),
    dispose: (_, db) {
      db.close();
    },
    child: MultiProvider(
      providers: [
        Provider<DayEntryRepository>(
          create: (context) => DayEntryRepository(
              Provider.of<AppDatabase>(context, listen: false)),
        ),
        Provider<UserRepository>(
          create: (context) =>
              UserRepository(Provider.of<AppDatabase>(context, listen: false)),
        ),
        Provider<CycleRepository>(
          create: (context) =>
              CycleRepository(Provider.of<AppDatabase>(context, listen: false)),
        ),
        Provider<NoteRepository>(
          create: (context) =>
              NoteRepository(Provider.of<AppDatabase>(context, listen: false)),
        ),
      ],
      child: MinaApp(),
    ),
  ));
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MultiBlocProvider(providers: [
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(
              userRepository:
                  Provider.of<UserRepository>(context, listen: false),
              cycleRepository:
                  Provider.of<CycleRepository>(context, listen: false),
              dayEntryRepository:
                  Provider.of<DayEntryRepository>(context, listen: false),
              dbHelper: Provider.of<AppDatabase>(context, listen: false),
            ),
          ),
          /* uncomment when done testing period day picker
          BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc()..add(OnboardingCompleted()),
          ), */
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          //Todo: remove this when fixed UI for PeriodDayPickerView
          BlocProvider(
              create: (context) => PeriodDayPickerBloc(
                  Provider.of<DayEntryRepository>(context, listen: false))
                ..add(PeriodDayPickerUptake(DateTime.now(), '1'))),
          BlocProvider(
              create: (context) =>
                  OnboardingBloc()..add(OnboardingNameSubmitted()))
        ], child: PeriodDayPickerView(focusedDay: DateTime.now())));
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
          return BlocProvider.value(
            value: context.read<AuthBloc>(),
            child: LoginView(),
          );
        }
      },
    );
  }
}
