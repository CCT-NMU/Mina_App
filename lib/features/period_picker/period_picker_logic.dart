import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/common/utils.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_events.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PeriodPickerLogic {
  String userId;
  DayEntryRepository dayEntryRepository;
  bool isOnboarding;
  PeriodPickerLogic(
    this.userId,
    this.dayEntryRepository,
    this.isOnboarding,
  );
  List<DateTime> deselecetedPeriodDates = [];

  //selectedDates are a list of all the dates that have been selected.
  Future<bool> saveEditedDays(
      Set<DateTime> selectedDates, Set<DateTime> oldPeriodSet) async {
    if (selectedDates.isEmpty) return Future.value(null);

    //  Sort the selected dates
    var sortedDates = selectedDates.toList()..sort();

    //
    deselecetedPeriodDates = oldPeriodSet.difference(selectedDates).toList()
      ..sort();

    var result = await saveCycles(sortedDates);

    return result;
  }

  Future<bool> saveCycles(List<DateTime> sortedDates) async {
    //  Group dates into contiguous ranges
    List<List<DateTime>> cycles = [];
    List<DateTime> currentCycle = [sortedDates.first];

    for (int i = 1; i < sortedDates.length; i++) {
      if (sortedDates[i].difference(sortedDates[i - 1]).inDays == 1) {
        currentCycle.add(sortedDates[i]);
      } else {
        cycles.add(currentCycle);
        currentCycle = [sortedDates[i]];
      }
    }
    cycles.add(currentCycle);

    // Prepare the new cycle records

    List<Cycle> newCycleRecords = [];
    for (int i = 0; i < cycles.length; i++) {
      var startDate = cycles[i].first;
      var periodEndDate = cycles[i].last;
      var endDate = (i < cycles.length - 1)
          ? cycles[i + 1].first.subtract(Duration(days: 1))
          : null; //cycle still to be completed

      newCycleRecords.add(Cycle(
          userId: userId,
          startDate: Utils().normalizedDate(startDate),
          periodEndDate: Utils()
                  .normalizedDate(periodEndDate)
                  .isAtSameMomentAs(Utils().normalizedDate(DateTime.now()))
              ? null
              : Utils().normalizedDate(periodEndDate),
          endDate: endDate != null ? Utils().normalizedDate(endDate) : null));
    }

    // Delete existing Cycle records for the affected months
    var affectedMonths =
        sortedDates.map((date) => DateTime(date.year, date.month, 1)).toSet();
    var affectedMonthsStart =
        affectedMonths.map((month) => month.toIso8601String()).toList();
    var affectedMonthsEnd = affectedMonths
        .map((date) => Utils()
            .normalizedDate(DateTime(date.year, date.month + 1, 1))
            .subtract(Duration(days: 1))
            .toIso8601String())
        .toList();

    // Delete existing Cycle records for the affected months using Supabase
    print('try deleting cycles for affected months: $affectedMonthsStart');
    print('try deleting cycles for affected months: $affectedMonthsEnd');
    try {
      for (int i = 0; i < affectedMonthsStart.length; i++) {
        await Supabase.instance.client
            .from('cycle')
            .delete()
            .or('and(start_date.gte.${affectedMonthsStart[i]},start_date.lte.${affectedMonthsEnd[i]}),and(end_date.gte.${affectedMonthsStart[i]},end_date.lte.${affectedMonthsEnd[i]})')
            .eq('user_id', userId);
      }
      // Insert new Cycle records
      for (var cycle in newCycleRecords) {
        await Supabase.instance.client.from('cycle').insert(cycle.toMap());
      }
    } catch (e) {
      print("Cycle data operation exception: $e");
      throw Exception("Cycle data operation exception: $e");
    }
    return savePeriodDays(newCycleRecords, cycles);
  }

  /*List<Cycle> startDate_and_endDate_CycleRecords and
      List<List<DateTime>> cycleDateTimeRangeList will always have the same size*/
  Future<bool> savePeriodDays(List<Cycle> cycleRecords,
      List<List<DateTime>> daysInCycleRangeList) async {
    List<List<DateTime>> cycles = daysInCycleRangeList;
    print('attempt to save period days');
    for (int i = 0; i < cycles.length; i++) {
      Cycle curCycle = cycleRecords[i];
      bool isOngoing = curCycle.periodEndDate == null;
      for (int j = 0; j < cycles[i].length; j++) {
        DateTime curDate = Utils().normalizedDate(cycles[i][j]);
        bool isStart = curDate == curCycle.startDate;
        bool isEnd =
            curCycle.periodEndDate == null || curDate == curCycle.periodEndDate;
        await dayEntryRepository.insertOrUpdatePeriodDayEntry(
          PeriodDay(
            date: curDate,
            flowWeight: FlowWeight.none, // or your default/desired value
            isPeriodStartDay: isStart,
            isPeriodEndDay: isEnd && !isOngoing,
          ),
          userId,
        );
      }
    }

    //###### Process normal Days ######

    //If a Day is not a PeriodDay anymore, it should be deleted from the PeriodDay table
    if (deselecetedPeriodDates.isNotEmpty) {
      for (DateTime date in deselecetedPeriodDates) {
        await dayEntryRepository.deletePeriodDayEntry(date, userId);
      }
    }
    //The database helper class helps on deletion of a PeriodDay entry by marking the
    //corresponding Day table isPeriodDay flag to false.
    return true;
  }
}
