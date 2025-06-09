import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/features/cycle_tracker/bloc/cycle_tracker_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_events.dart';
import 'package:mina_app/features/dashboard/view/dashboard_view.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_bloc.dart';
import 'package:mina_app/features/day_entry/bloc/day_entry_event.dart';
import 'package:mina_app/features/day_entry/view/day_entry_view.dart';
import 'package:mina_app/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mina_app/features/period_picker/period_picker_logic.dart';
import 'package:mina_app/local_libraries/table_calendar/lib/table_calendar.dart';
import 'package:mina_app/local_libraries/table_calendar/lib/src/shared/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/period_picker/period_picker_logic.dart';
import 'package:path/path.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'bloc/period_day_picker_bloc.dart';
import 'bloc/period_day_picker_event.dart';
import 'bloc/period_day_picker_state.dart';

/*A view of days that a user can choose to be a period day
//The purpose of this view is to clarify  the user's start and end days of their period
//and allow them to choose the days that they want to be a period day
//The interaction is triggered from the Day_Entry view upon tapping the 
// appropriate button. 
// The appropriate button [period_pick_trigger] on the Day_Entry view is determined by
// 2 factors, app state and the day the user is looking at. 
// The app state is determined by where in the 
// cycle the user is. The day is determined by the day the Day_Entry view is for.
// The Day entry UI will adjust to whether the day falls within the current cycle
// and whether the day is a period day or not.
For instance in the case of a Day falling in a previous cycle
 that is not a period day, the [period_pick_trigger] button will not exist.
The [period_pick_trigger] button is responsible for taking the user to this view. 
It will only appear for days that:
# are period start and end days within past menstrual cycles.
# are in the current cycle
    ->The [period_pick_trigger] will prompt user to choose a start period day if the current cycle state == PeriodEnded.
    ->The [period_pick_trigger] will prompt user to choose an end period day if the current cycle state == currentPeriodOngoing.
    ->The current cycle is demarcated by the latest periodStartday. Therefore upon saving 
      the entries in this view the currentperiodStartday will be updated to reflect the latest current cycle
      

*/

/*TODO: Get the date of the day being edited and check which number month it falls in. 
        Make the day picker view display the month of the day being edited by scrolling to the
        number month*/
class PeriodDayPickerView extends StatelessWidget {
  final DateTime? focusedDay;
  const PeriodDayPickerView({Key? key, this.focusedDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _PeriodDayPickerBody(focusedDay: focusedDay ?? DateTime.now());
  }
}

class _PeriodDayPickerBody extends StatefulWidget {
  final DateTime? focusedDay;
  const _PeriodDayPickerBody({Key? key, this.focusedDay}) : super(key: key);

  @override
  State<_PeriodDayPickerBody> createState() => _PeriodDayPickerBodyState();
}

class _PeriodDayPickerBodyState extends State<_PeriodDayPickerBody> {
  final ItemScrollController _itemScrollController = ItemScrollController();

  //for onboarding
  int _firstVisibleIndex = -1;
  int _lastVisibleIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var previousMonths;
  var currentMonths;
  @override
  Widget build(BuildContext context) {
    final OnboardingBloc onboardingBloc = context.read<OnboardingBloc>();
    //OnboardingBloc

    return MultiBlocListener(
      listeners: [
        BlocListener<PeriodDayPickerBloc, PeriodDayPickerState>(
            listenWhen: (previous, current) =>
                previous.status == PeriodDayPickerStatus.saving &&
                current.status == PeriodDayPickerStatus.success,
            listener: (context, state) {
              if (onboardingBloc.state is OnboardingInProgress) {
                onboardingBloc.add(LastPeriodPickerViewSubmitted());
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                            value: onboardingBloc,
                            child: MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => DashboardBloc(),
                                ),
                                BlocProvider(
                                  create: (context) => CycleTrackerBloc()
                                    ..add(CycleTrackerStarted()),
                                ),
                              ],
                              child: const DashboardView(),
                            ),
                          )),
                );
              } else {
                context
                    .read<DayEntryBloc>()
                    .add(DayEntryFetch(widget.focusedDay!));
                Navigator.pop(context);
              }
            }),
      ],
      child: BlocBuilder<PeriodDayPickerBloc, PeriodDayPickerState>(
        builder: (context, state) {
          if (state.status == PeriodDayPickerStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 120,
                title: Container(
                  child: Column(
                    children: [
                      Text('My period started'),
                      Text(
                          //ToDO: Replace this with the date of the day being edited
                          '${DateFormat.E().format(widget.focusedDay!)}, ${DateFormat.MMMd().format(widget.focusedDay!)}',
                          style: const TextStyle(fontSize: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                                .map((d) => Expanded(
                                        child: Center(
                                            child: Container(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        d,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ))))
                                .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child:
                        //ToDo remove the dead bloc Listener code
                        BlocListener<PeriodDayPickerBloc, PeriodDayPickerState>(
                      listenWhen: (previous, current) {
                        if (previous.months.isEmpty || current.months.isEmpty) {
                          return false;
                        } else {
                          return current.months.first.month !=
                              previous.months.first.month;
                        }
                      },
                      listener: (context, state) {
                        // Find the new index of the previously first visible month
                        /* final prevMonth = state.prevMonthListFirstMonth ?? null;
                          if (prevMonth != null) {
                            final newIndex = state.months.indexWhere((m) =>
                                m.year == prevMonth.year &&
                                m.month == prevMonth.month);
                            if (newIndex != -1) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _itemScrollController.jumpTo(index: newIndex);
                              });
                            } 
                          }*/
                        Future.delayed(const Duration(seconds: 1), () {
                          _itemScrollController.jumpTo(index: 5);
                        });
                      },
                      child: BlocBuilder<PeriodDayPickerBloc,
                          PeriodDayPickerState>(
                        builder: (context, state) {
                          return ScrollablePositionedList.builder(
                            reverse: true,
                            itemScrollController: _itemScrollController,
                            itemCount: state.months.length,
                            itemBuilder: (context, index) {
                              final month = state.months[index];
                              return buildMonthCalendar(
                                  context, month, state.selectedDays, index);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 42.0, vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(84, 33, 149, 243),
                                foregroundColor: Colors.white,
                              ),
                              child: Text("Close",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                              onPressed: () async {
                                context
                                    .read<PeriodDayPickerBloc>()
                                    .add(SavedPeriodDays(context));

                                // Navigate to Day_Entry view with the current Day Entry
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 42.0, vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(81, 243, 33, 180),
                                foregroundColor:
                                    const Color.fromARGB(255, 0, 0, 0),
                              ),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }

  Widget buildMonthCalendar(BuildContext context, DateTime month,
      Set<DateTime> selectedPeriodDateSet, int index) {
    final days = daysInMonth(month);
    final startWeekday = DateTime(month.year, month.month, 1).weekday % 7;
    final totalGridCount = startWeekday + days;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              DateFormat.yMMMM().format(month),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.all(12),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: totalGridCount,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
            itemBuilder: (context, index) {
              if (index < startWeekday) return Container();

              final day = index - startWeekday + 1;
              final date = DateTime(month.year, month.month, day);
              var now = DateTime.now();
              //Disable future day selection
              final isFutureDay =
                  date.isAfter(DateTime(now.year, now.month, now.day));
              var isSelected = selectedPeriodDateSet
                  .contains(DateTime(date.year, date.month, date.day));

              return GestureDetector(
                onTap: () {
                  if (!isFutureDay) {
                    //Only add to selected days if it is not a future day
                    context
                        .read<PeriodDayPickerBloc>()
                        .add(PeriodDayToggled(date));
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Container(
                        child: Column(
                          children: [
                            Text('$day',
                                style: TextStyle(
                                  color: isFutureDay
                                      ? Colors.grey
                                      : isSelected
                                          ? const Color.fromARGB(
                                              255, 235, 43, 43)
                                          : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                )),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: isFutureDay
                                    ? Border.all(color: Colors.grey, width: 2)
                                    : isSelected
                                        ? Border.all(
                                            color: Colors.pinkAccent, width: 2)
                                        : Border.all(
                                            color: const Color.fromARGB(
                                                255, 116, 103, 107),
                                            width: 2),
                                color: isFutureDay
                                    ? Colors.grey.shade200
                                    : isSelected
                                        ? Colors.pinkAccent
                                        : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  isSelected ? Icons.check : null,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  int daysInMonth(DateTime month) {
    final beginningNextMonth = (month.month == 12)
        ? DateTime(month.year + 1, 1, 1)
        : DateTime(month.year, month.month + 1, 1);
    return beginningNextMonth.subtract(Duration(days: 1)).day;
  }
}

class CustomRectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.55),
        width: size.width,
        height: size.height * 0.4);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class CustomRectLeftClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: Offset(size.width, size.height * 0.55),
        width: size.width,
        height: size.height * 0.4);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class CustomRectRightClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: Offset(-size.width, size.height * 0.55),
        width: size.width,
        height: size.height * 0.4);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
