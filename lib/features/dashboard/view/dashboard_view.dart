import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/features/cycle_tracker/bloc/cycle_tracker_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_events.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_states.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_event.dart';
import 'package:mina_app/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mina_app/features/widgets/common/menu/menu_drawer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mina_app/features/day_entry/view/day_entry_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:intl/intl.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    BlocProvider.of<DashboardBloc>(context).add(LoadDashboard(_focusedDay));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('Mina'),
                ),
                SliverToBoxAdapter(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    // Hero Section
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(178, 132, 77, 151),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to My Mina!",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Track your days and stay organized.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
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
                          final periodDays = state.days;
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: myCalendar(periodDays)),
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
                                title: const Text("Understanding Your Cycle"),
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
                        description: "Tips for maintaining menstrual health.",
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
                        description: "Explore common symptoms and remedies.",
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
            drawer: const MenuDrawer(),
          ),
        );
      },
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
          future: DayEntryRepository.instance.getDayEntry(focusedDay),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text('Error: ${snapshot.error}')),
              );
            }
            if (snapshot.data is PeriodDay) {
              final periodDay = snapshot.data as PeriodDay;
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                      value: cycleTrackerBloc
                        ..add(const CycleTrackerStarted())),
                  BlocProvider.value(value: dashboardBloc),
                  BlocProvider(
                    create: (_) =>
                        DayEntryBloc()..add(DayEntryFetch(focusedDay)),
                  ),
                ],
                child: DayEntryView(
                  focusedDay: focusedDay,
                  existingDay: periodDay,
                ),
              );
            } else if (snapshot.data is Day) {
              final day = snapshot.data as Day;
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: cycleTrackerBloc),
                  BlocProvider.value(value: dashboardBloc),
                  BlocProvider(
                    create: (_) =>
                        DayEntryBloc()..add(DayEntryFetch(focusedDay)),
                  ),
                ],
                child: DayEntryView(
                  focusedDay: focusedDay,
                  existingDay: day,
                ),
              );
            }
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: cycleTrackerBloc),
                BlocProvider.value(value: dashboardBloc),
                BlocProvider(
                  create: (_) => DayEntryBloc()..add(DayEntryFetch(focusedDay)),
                ),
              ],
              child: DayEntryView(
                focusedDay: focusedDay,
                existingDay: snapshot.data,
              ),
            );
          },
        );
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

  Widget myCalendar(List<Day> periodDays) {
    return TableCalendar(
      firstDay: DateTime.utc(1670, 1, 1),
      lastDay: DateTime.utc(DateTime.now().year + 10, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      calendarFormat: CalendarFormat.month,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      onDaySelected: (selectedDay, focusedDay) async {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        final dashboardBloc = context.read<DashboardBloc>();
        final cycleTrackerBloc = context.read<CycleTrackerBloc>();
        final result = await Navigator.of(context).push(_createRoute(
            normalizeDate(_focusedDay), dashboardBloc, cycleTrackerBloc));
        if (result == true) {
          dashboardBloc.add(LoadDashboard(_focusedDay));
        }
      },
      onPageChanged: (focusedDay) {
        context.read<DashboardBloc>().add(CalendarChanged(focusedDay));
        setState(() {
          _focusedDay = focusedDay;
        });
      },
      calendarBuilders: CalendarBuilders(
        prioritizedBuilder: (context, day, focusedDay) {
          final Day dayEntry = periodDays.firstWhere(
            (d) => normalizeDate(d.date) == normalizeDate(day),
            orElse: () => Day(date: DateTime(0, 0, 0), isPeriodDay: false),
          );

          bool isPeriodDay = false;
          bool isToday = normalizeDate(day) == normalizeDate(DateTime.now());
          bool hasNote = false;
          bool hasMood_or_Symptoms = false;

          if (dayEntry.date != DateTime(0, 0, 0)) {
            isPeriodDay = dayEntry.isPeriodDay == true;
            hasNote = dayEntry.note != null && dayEntry.note != "";
            hasMood_or_Symptoms =
                (dayEntry.moodList?.moods.isNotEmpty ?? false) ||
                    (dayEntry.symptomList?.symptoms.isNotEmpty ?? false);
          }
          return Container(
            width: 50,
            decoration: BoxDecoration(
                color: isPeriodDay ? Color.fromARGB(120, 244, 67, 54) : null,
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
                  child: Icon(Icons.favorite, size: 14, color: Colors.purple),
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
}
