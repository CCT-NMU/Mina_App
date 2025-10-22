import 'package:flutter/material.dart';
import 'package:mina_app/common/utils.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/features/cycle_tracker/bloc/cycle_tracker_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_events.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_states.dart';
import 'package:mina_app/features/dashboard/calendar/cubit/calendar_cubit.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_event.dart';
import 'package:mina_app/features/widgets/common/menu/menu_drawer.dart';
import 'package:mina_app/services/prediction_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mina_app/features/day_entry/view/day_entry_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/services/auth_service/platform/supabase_auth_service.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late DateTime currentFocusedDay;
  DateTime? _selectedDay;
  String periodDayStatus = '6';
  PredictionService predictionService =
      PredictionService(cycleRepository: CycleRepository());
  // Get current user ID from AuthService
  String get currentUserId => SupabaseAuthService().currentUserId!;
  @override
  void initState() {
    super.initState();
    currentFocusedDay = DateTime.now();
    Provider.of<CycleTrackerBloc>(context, listen: false)
        .add(const CycleTrackerStarted());
    Provider.of<DashboardBloc>(context, listen: false)
        .add(LoadDashboard(currentFocusedDay));
  }

  @override
  Widget build(BuildContext context) {
    // Get user info for display
//    final userName = AuthService.instance.currentUserName ?? 'User';
    var userName = SupabaseAuthService().currentUserName ?? 'User';
    var userId = SupabaseAuthService().currentUser!.id;
    return BlocProvider(
      create: (context) => CalendarCubit(
        dayEntryRepository: context.read<DayEntryRepository>(),
        predictionService:
            PredictionService(cycleRepository: CycleRepository()),
      )..loadInitialCalendar(currentFocusedDay),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          print('DashboardView: Building with state: $state');
          return SafeArea(
            child: Scaffold(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              body: Container(
                padding: Utils().responsiveHorizontalPadding(context),
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(55, 227, 183, 235),
                      Color.fromARGB(55, 233, 30, 98)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      title: const Text('Mina'),
                    ),
                    SliverToBoxAdapter(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        // Hero Section
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.28,
                          width: double.infinity,
                          /*  */
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 16),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(178, 132, 77, 151),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                "Welcome to My Mina $userName!",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.sizeOf(context).height * 0.025,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  "Track your days and stay organized.",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.02,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  "$periodDayStatus days until your next period.",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.02,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Calendar Section
                        BlocBuilder<DashboardBloc, DashboardState>(
                          builder: (context, state) {
                            if (state is DashboardLoadInProgress) {
                              return Center(
                                  heightFactor:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: CircularProgressIndicator());
                            }
                            if (state is DashboardLoadSuccess) {
                              var periodDays =
                                  <Day>[]; //state.days; ToDo: Pull in Calendar Cubit
                              var nextPeriod = state.nextPeriodDate;
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                      value: context.read<DashboardBloc>()),
                                  //Start up the CycleTracker
                                  BlocProvider.value(
                                      value: context.read<CycleTrackerBloc>()),

                                  //Start up the DayEntry
                                ],
                                child: SizedBox(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 0.0),
                                      child:
                                          myCalendar(periodDays, nextPeriod)),
                                ),
                              );
                            } else if (state is DashboardLoadFailure) {
                              return const Center(
                                  heightFactor: 2,
                                  child: Text('Failed to load events'));
                            }
                            return Center(
                                heightFactor:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: CircularProgressIndicator());
                          },
                        ),
                      ]),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          _buildInfoSection(
                            context,
                            title: "Understanding Your Cycle",
                            description:
                                "Learn about the phases of your menstrual cycle.",
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title:
                                        const Text("Understanding Your Cycle"),
                                    content: const Text(
                                      "The menstrual cycle has four phases: menstrual, follicular, ovulation, and luteal. "
                                      "Each phase plays a vital role in your reproductive health.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          _buildInfoSection(
                            context,
                            title: "Healthy Habits",
                            description:
                                "Tips for maintaining menstrual health.",
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Healthy Habits"),
                                    content: const Text(
                                      "Maintain a balanced diet, stay hydrated, exercise regularly, and get enough sleep "
                                      "to support your menstrual health.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          _buildInfoSection(
                            context,
                            title: "Common Symptoms",
                            description:
                                "Explore common symptoms and remedies.",
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Common Symptoms"),
                                    content: const Text(
                                      "Common menstrual symptoms include cramps, bloating, mood swings, and fatigue. "
                                      "Remedies include pain relievers, heat therapy, and relaxation techniques.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              drawer: const MenuDrawer(),
            ),
          );
        },
      ),
    );
  }

  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Widget _buildInfoSection(BuildContext context,
      {required String title,
      required String description,
      required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Route _createRoute(DateTime focusedDay, DashboardBloc dashboardBloc,
      CycleTrackerBloc cycleTrackerBloc) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FutureBuilder<Day?>(
            future: Provider.of<DayEntryRepository>(context, listen: false)
                .getDayEntry(focusedDay, currentUserId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text('Error: ${snapshot.error}')),
                );
              }
              //Period Day
              if (snapshot.data is PeriodDay) {
                var periodDay = snapshot.data as PeriodDay;
                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                        value: cycleTrackerBloc
                          ..add(const CycleTrackerStarted())),
                    BlocProvider.value(value: dashboardBloc),
                    BlocProvider(
                      create: (_) => DayEntryBloc(
                          dayEntryRepository: Provider.of<DayEntryRepository>(
                              context,
                              listen: false),
                          cycleRepository: Provider.of<CycleRepository>(context,
                              listen: false))
                        ..add(DayEntryFetch(focusedDay, currentUserId)),
                    ),
                  ],
                  child: DayEntryView(
                    focusedDay: focusedDay,
                    existingDay: periodDay,
                    userId: currentUserId,
                  ),
                );
                //Normal Day
              } else if (snapshot.data is Day) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: cycleTrackerBloc),
                    BlocProvider.value(value: dashboardBloc),
                    BlocProvider(
                      create: (_) => DayEntryBloc(
                          dayEntryRepository: Provider.of<DayEntryRepository>(
                              context,
                              listen: false),
                          cycleRepository: Provider.of<CycleRepository>(context,
                              listen: false))
                        ..add(DayEntryFetch(focusedDay, currentUserId)),
                    ),
                  ],
                  child: DayEntryView(
                    focusedDay: focusedDay,
                    existingDay: snapshot.data,
                    userId: currentUserId,
                  ),
                );
              }
              //Empty Day with no record yet
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: cycleTrackerBloc),
                  BlocProvider.value(value: dashboardBloc),
                  BlocProvider(
                    create: (_) => DayEntryBloc(
                        dayEntryRepository: Provider.of<DayEntryRepository>(
                            context,
                            listen: false),
                        cycleRepository: Provider.of<CycleRepository>(context,
                            listen: false))
                      ..add(DayEntryFetch(focusedDay, currentUserId)),
                  ),
                ],
                child: DayEntryView(
                  focusedDay: focusedDay,
                  existingDay: snapshot.data,
                  userId: currentUserId,
                ),
              );
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

  Widget myCalendar(List<Day> periodDays, DateTime? nextPeriodDay) {
    Map<String, Cycle> predictedCycles = {}; // Placeholder for predicted days
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        if (state is CalendarLoaded) {
          final periodDays = state.cachedmonths[
                  '${currentFocusedDay.year}-${currentFocusedDay.month}'] ??
              [];
          predictedCycles = state.predictedCycles;
          return TableCalendar(
            firstDay: DateTime.utc(1670, 1, 1),
            lastDay: DateTime.utc(DateTime.now().year + 10, 12, 31),
            focusedDay: currentFocusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: CalendarFormat.month,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            onDaySelected: (selectedDay, focusedDay) async {
              setState(() {
                _selectedDay = selectedDay;
                currentFocusedDay = focusedDay;
                print('This is the focused day $currentFocusedDay');
                print('This is the selected day $_selectedDay');
              });
              final dashboardBloc = context.read<DashboardBloc>();
              final cycleTrackerBloc = context.read<CycleTrackerBloc>();
              var result = await Navigator.of(context).push(_createRoute(
                  normalizeDate(_selectedDay!),
                  dashboardBloc,
                  cycleTrackerBloc));
              if (result == true) {
                dashboardBloc.add(LoadDashboard(currentFocusedDay));
              }
            },
            onPageChanged: (focusedDay) {
              context.read<CalendarCubit>().handleScroll(focusedDay);
              setState(() {
                currentFocusedDay = focusedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              prioritizedBuilder: (context, day, focusedDay) {
                final Day dayEntry = periodDays.firstWhere(
                  (d) => normalizeDate(d.date) == normalizeDate(day),
                  orElse: () =>
                      Day(date: DateTime(0, 0, 0), isPeriodDay: false),
                );

                bool isPeriodDay = false;
                bool isToday =
                    normalizeDate(day) == normalizeDate(DateTime.now());
                bool hasNote = false;
                bool hasMood_or_Symptoms = false;
                bool isPredictedPeriodDay = false;
                bool isPredictedCycleDay = false;
                if (dayEntry.date != DateTime(0, 0, 0)) {
                  isPeriodDay = dayEntry.isPeriodDay == true;
                  hasNote = dayEntry.note != null && dayEntry.note != "";
                  isPredictedPeriodDay = dayEntry.date == nextPeriodDay;
                  hasMood_or_Symptoms =
                      (dayEntry.moodList?.moods.isNotEmpty ?? false) ||
                          (dayEntry.symptomList?.symptoms.isNotEmpty ?? false);
                }
                if (predictedCycles.keys.toList().any((key) {
                  DateTime startDate = DateTime.parse(key);
                  Cycle cycle = predictedCycles[key]!;
                  DateTime endDate = cycle.periodEndDate!;
                  return normalizeDate(day)
                          .isAtSameMomentAs(normalizeDate(startDate)) ||
                      (normalizeDate(day).isAfter(normalizeDate(startDate)) &&
                          normalizeDate(day)
                              .isBefore(normalizeDate(endDate))) ||
                      normalizeDate(day)
                          .isAtSameMomentAs(normalizeDate(endDate));
                })) {
                  isPredictedCycleDay = true;
                }
                return Container(
                  width: 50,
                  decoration: BoxDecoration(
                      color: isPeriodDay
                          ? Color.fromARGB(120, 244, 67, 54)
                          : isPredictedCycleDay
                              ? Color.fromARGB(245, 0, 255, 157)
                              : null,
                      shape: BoxShape.circle,
                      border: isToday
                          ? Border.all(
                              color: const Color.fromARGB(255, 54, 111, 244),
                              width: 2,
                            )
                          : null),
                  child: Stack(alignment: Alignment.center, children: [
                    Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: isPeriodDay ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (hasNote)
                      const Positioned(
                        bottom: 4,
                        right: 4,
                        child: Icon(Icons.edit, size: 14, color: Colors.purple),
                      ),
                    if (hasMood_or_Symptoms)
                      const Positioned(
                        bottom: 4,
                        left: 4,
                        child: Icon(Icons.favorite,
                            size: 14, color: Colors.purple),
                      )
                  ]),
                );
              },
            ),
            calendarStyle: const CalendarStyle(
              withinRangeDecoration: BoxDecoration(
                color: Color.fromARGB(116, 255, 102, 199),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              rangeHighlightColor: Color.fromARGB(124, 255, 102, 224),
              markerDecoration: BoxDecoration(
                color: null,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(0, 76, 175, 79),
                shape: BoxShape.circle,
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
