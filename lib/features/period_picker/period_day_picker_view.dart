import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/data/repositories/user_repository.dart';
import 'package:mina_app/features/auth/bloc/auth_bloc.dart';
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
import 'package:mina_app/services/auth_service/platform/supabase_auth_service.dart';
import 'package:mina_app/services/prediction_service.dart';
import 'package:provider/provider.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'bloc/period_day_picker_bloc.dart';

/*A view of days that a user can choose to be a period day
//The purpose of this view is to clarify  the user's start and end days of their period
//and allow them to choose the days that they want to be a period day
//The interaction is triggered from the Day_Entry view upon tapping the 
// appropriate button. 
// The appropriate button [period_pick_trigger] on the Day_Entry view is determined by
// 2 factors, Present Cycle state and the day the user is looking at. 
// The Present Cycle state is determined by where in the 
// cycle the user is. The day is determined by the day the Day_Entry view is for.
// The Day entry UI will adjust to whether or not the day falls within the Present cycle
// and whether the day is a period day or not.
For instance in the case of a Day falling in a previous cycle
 that is not a period day, the [period_pick_trigger] button will not exist.
The [period_pick_trigger] button is responsible for taking the user to this view. 
It will only appear for :
# days that are period start and end days within past menstrual cycles.
# days that are in the present cycle
    ->The [period_pick_trigger] will prompt user to choose a start period day if the current cycle state == DayEntryInPresentCycleState OR PastDayEntryOutOfCycleState.
    ->The [period_pick_trigger] will prompt user to choose an end period day if the current cycle state == PeriodDayEntryOngoingPeriodState OR PeriodDayEntryInHistoricalCycleState where isPeriodEndDay == true.
    ->The present cycle is demarcated by the latest periodStartday. Therefore upon saving 
      the entries in this view the present Cycle's periodStartDay will be updated 
      

*/

class PeriodDayPickerView extends StatefulWidget {
  final DateTime? focusedDay;
  final String userId = SupabaseAuthService().currentUserId!;
  PeriodDayPickerView({Key? key, this.focusedDay}) : super(key: key);

  @override
  State<PeriodDayPickerView> createState() => _PeriodDayPickerViewState();
}

class _PeriodDayPickerViewState extends State<PeriodDayPickerView> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  Timer? _debounce;
  int _firstVisible = 0;
  int _lastVisible = 0;

  @override
  void initState() {
    super.initState();
    var bloc = context.read<PeriodDayPickerBloc>();

    bloc.stream.listen((state) {
      //After days update, restore scroll if needed

      if (state.preservedScrollIndex != null && state.monthsAdded > 0) {
        var targetIndex = state.preservedScrollIndex!;

        // Try to find the previous position of the target index

        // Default alignment if position not found
        double alignment = 0;

        if (state.leadingEdge != null) {
          alignment = state.leadingEdge!;
        }
        print("alignment: $alignment" "targetIndex: $targetIndex");
        if (_itemScrollController.isAttached) {
          _itemScrollController.jumpTo(
            index: targetIndex,
            alignment: alignment,
          );
        }
      }
    });

    void onScroll() {
      var positions = _itemPositionsListener.itemPositions.value;
      if (positions.isEmpty) return;

      var first = positions
          .where((p) => p.itemLeadingEdge >= 0 && p.itemLeadingEdge <= 1)
          .reduce((min, p) => p.index < min.index ? p : min);
      _firstVisible = first.index;

      var last = positions
          .where((p) => p.itemTrailingEdge <= 1 && p.itemTrailingEdge >= 0)
          .reduce((max, p) => p.index > max.index ? p : max);

      _lastVisible = last.index;

      print('first: $_firstVisible, last: $_lastVisible');
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 100), () {
        if (_lastVisible >=
                context.read<PeriodDayPickerBloc>().state.months.length - 2 &&
            _firstVisible >=
                context.read<PeriodDayPickerBloc>().state.months.length - 1) {
          context.read<PeriodDayPickerBloc>().add(
              LoadMoreMonthsBackward(_firstVisible, first.itemLeadingEdge));
        }

        if (_firstVisible == 0 && _lastVisible == 0) {
          context.read<PeriodDayPickerBloc>().add(LoadMoreMonthsForward(
              _firstVisible, 0)); //TODO remove first.itemLeadingEdge.
        }
      });
    }

    _itemPositionsListener.itemPositions.addListener(onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    OnboardingBloc onboardingBloc = context.read<OnboardingBloc>();
    //OnboardingBloc

    return MultiBlocListener(
      listeners: [
        BlocListener<PeriodDayPickerBloc, PeriodDayPickerState>(
            listenWhen: (previous, current) =>
                previous.status == PeriodDayPickerStatus.saving &&
                current.status == PeriodDayPickerStatus.success,
            listener: (context, state) {
              if (onboardingBloc.state is OnboardingInProgress &&
                  state.status == PeriodDayPickerStatus.success) {
                onboardingBloc.add(LastPeriodPickerViewSubmitted());
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                            value: onboardingBloc,
                            child: MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => CycleTrackerBloc(
                                      Provider.of<CycleRepository>(context,
                                          listen: false)),
                                ),
                                BlocProvider<DashboardBloc>(
                                  create: (context) => DashboardBloc(
                                    userRepository: Provider.of<UserRepository>(
                                        context,
                                        listen: false),
                                    cycleRepository:
                                        Provider.of<CycleRepository>(context,
                                            listen: false),
                                    dayEntryRepository:
                                        Provider.of<DayEntryRepository>(context,
                                            listen: false),
                                    dbHelper: Provider.of<AppDatabase>(context,
                                        listen: false),
                                  ),
                                ),
                                BlocProvider(
                                  create: (context) => AuthBloc(),
                                )
                              ],
                              child: const DashboardView(),
                            ),
                          )),
                );
              } else {
                context
                    .read<DayEntryBloc>()
                    .add(DayEntryFetch(widget.focusedDay!, widget.userId));
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
                      Text('Select period days',
                          style: TextStyle(fontSize: 20)),
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
                        BlocBuilder<PeriodDayPickerBloc, PeriodDayPickerState>(
                      builder: (context, state) {
                        return ScrollablePositionedList.builder(
                          reverse: true,
                          itemScrollController: _itemScrollController,
                          itemPositionsListener: _itemPositionsListener,
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
                              onPressed: state.selectedDays.isEmpty
                                  ? null
                                  : () async {
                                      if (context.read<OnboardingBloc>().state
                                          is OnboardingComplete) {
                                        context.read<PeriodDayPickerBloc>().add(
                                            SavedPeriodDays(
                                                context, widget.userId, false));
                                        context.read<DayEntryBloc>().add(
                                            DayEntryFetch(widget.focusedDay!,
                                                widget.userId));
                                      }
                                      if (context.read<OnboardingBloc>().state
                                          is OnboardingInProgress) {
                                        context.read<PeriodDayPickerBloc>().add(
                                            SavedPeriodDays(
                                                context, widget.userId, true));
                                      }

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
                        width: _getCircleWidth(context),
                        height: _getCircleWidth(context),
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
                            AnimatedContainer(
                              duration: Duration(microseconds: 400),
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

  double _getCircleWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 400) {
      return 20; // Small phones
    } else if (screenWidth < 800) {
      return 40; // Tablets or large phones
    } else {
      return 48; // Desktop or large tablets
    }
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
