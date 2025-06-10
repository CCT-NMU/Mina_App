import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/common/utils.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_events.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:flutter/foundation.dart';

class PeriodPickerLogic {
  PeriodPickerLogic();
  List<DateTime> deselecetedPeriodDates = [];

  //selectedDates are a list of all the dates that have been selected.
  Future<bool> saveEditedDays(Set<DateTime> selectedDates,
      Set<DateTime> oldPeriodSet, BuildContext context) async {
    if (selectedDates.isEmpty) return Future.value(null);

    //  Sort the selected dates
    final sortedDates = selectedDates.toList()..sort();

    //
    deselecetedPeriodDates = oldPeriodSet.difference(selectedDates).toList()
      ..sort();
    saveCycles(sortedDates);

    final result = await saveCycles(sortedDates);

    return result;
  }

  Future<bool> saveCycles(List<DateTime> sortedDates) async {
    final Database db = await DatabaseHelper().database;
    //  Group dates into contiguous ranges
    final List<List<DateTime>> cycles = [];
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
    //TODO: Make exception for initial cycle entry for new users: periodEndDate may not be reached yet.
    //...Perhaps if last day in period selection is DateTime.now() we must set periodEndDate to null
    //--
    final List<Cycle> newCycleRecords = [];
    for (int i = 0; i < cycles.length; i++) {
      final startDate = cycles[i].first;
      final periodEndDate = cycles[i].last;
      final endDate = (i < cycles.length - 1)
          ? cycles[i + 1].first.subtract(Duration(days: 1))
          : null; //cycle still to be completed

      newCycleRecords.add(Cycle(
          startDate: Utils().normalizedDate(startDate),
          periodEndDate: Utils().normalizedDate(periodEndDate),
          endDate: endDate != null ? Utils().normalizedDate(endDate) : null));
    }

    // Delete existing Cycle records for the affected months
    final affectedMonths =
        sortedDates.map((date) => DateTime(date.year, date.month, 1)).toSet();
    final affectedMonthsStart =
        affectedMonths.map((month) => month.toIso8601String()).toList();
    final affectedMonthsEnd = affectedMonths
        .map((date) => DateTime(date.year, date.month + 1, 1)
            .subtract(Duration(days: 1))
            .toIso8601String())
        .toList();

    return await db.transaction((txn) async {
      //Process periodDays into database

      for (int i = 0; i < affectedMonthsStart.length; i++) {
        await txn.delete(
          'Cycle',
          where: '(startDate BETWEEN ? AND ?) OR (endDate BETWEEN ? AND ?)',
          whereArgs: [
            affectedMonthsStart[i],
            affectedMonthsEnd[i],
            affectedMonthsStart[i],
            affectedMonthsEnd[i],
          ],
        );
      }

      // Insert the new cycle records
      for (final record in newCycleRecords) {
        await txn.insert('Cycle', record.toMap());
      }
      return savePeriodDays(newCycleRecords, cycles, txn);
    });
  }

  /*List<Cycle> startDate_and_endDate_CycleRecords and
      List<List<DateTime>> cycleDateTimeRangeList will always have the same size*/
  Future<bool> savePeriodDays(List<Cycle> cycleRecords,
      List<List<DateTime>> daysInCycleRangeList, Transaction txn) async {
    List<List<DateTime>> cycles = daysInCycleRangeList;

    for (int i = 0; i < cycles.length; i++) {
      Cycle curCycle = cycleRecords[i];
//#### Process PeriodDays ####
      for (int j = 0; j < cycles[i].length; j++) {
        // Normalize date to remove time
        DateTime curDate = Utils().normalizedDate(cycles[i][j]);

        // 1. Try to get existing PeriodDay for this date
        PeriodDay? existingPeriodDay =
            await DatabaseHelper().getPeriodDayByDate(curDate, txn: txn);

        //1.1 Check to see if the day exists in Day table
        Day? existingDay = await DatabaseHelper().getDay(curDate, txn: txn);
        //If a DateTime matches an existing PeriodDay in the PeriodDay table
        //it should only be updated if it is now a periodStartDay or periodEndDay.

        //If a Day record exists in the database that needs to be changed from a periodStartDay
        // [or periodEndDay]..
        //to a normal PeriodDay, we should update the entry by changing the flags as necessary

        //*****Process edge case where only one Period day exists in a Cycle*****
        //*****This will be a periodStartDay and periodEndDay*****
        if (curDate == curCycle.startDate &&
            curDate == curCycle.periodEndDate) {
          //if it the record does not exist in PeriodDay table
          if (existingPeriodDay == null) {
            if (existingDay == null) {
              await DayEntryRepository.instance.insertPeriodDayEntry(
                  PeriodDay(
                    date: curDate,
                    flowWeight:
                        FlowWeight.none, // or your default/desired value
                    isPeriodStartDay: true,
                    isPeriodEndDay: true,
                  ),
                  txn);
            } else {
              await DayEntryRepository.instance.updateDayToPeriodDay(
                  PeriodDay(
                    date: curDate,
                    flowWeight:
                        FlowWeight.none, // or your default/desired value
                    isPeriodStartDay: true,
                    isPeriodEndDay: true,
                  ),
                  txn);
            }
          } else {
            //record does exist, update it as a start and end day
            PeriodDay updated = existingPeriodDay.copyWith(
                isPeriodStartDay: true, isPeriodEndDay: true);
            await DatabaseHelper().updatePeriodDay(updated, txn: txn);
          }
        }

        //*****Process Start Day Period*****
        if (curDate == curCycle.startDate &&
            curDate != curCycle.periodEndDate) {
          if (existingPeriodDay != null) {
            // 2. If it exists and is already a start day, do nothing
            if (!existingPeriodDay.isPeriodStartDay) {
              // 3. If not a start day, update it to be a start day, keep flowWeight
              PeriodDay updated = existingPeriodDay.copyWith(
                  isPeriodStartDay: true, isPeriodEndDay: false);
              await DatabaseHelper().updatePeriodDay(updated, txn: txn);
            }
          } else {
            // 4. If it does not exist, insert/update as start day
            if (existingDay == null) {
              PeriodDay newPeriodDay = PeriodDay(
                date: curDate,
                flowWeight: FlowWeight.none, // or your default/desired value
                isPeriodStartDay: true,
                isPeriodEndDay: false,
              );
              await DatabaseHelper().insertPeriodDay(newPeriodDay, txn: txn);
            } else {
              await DayEntryRepository.instance.updateDayToPeriodDay(
                PeriodDay(
                  date: curDate,
                  flowWeight: FlowWeight.none,
                  isPeriodStartDay: true,
                  isPeriodEndDay: false,
                ),
                txn,
              );
            }
          }
        }

        // Process PeriodDays (middle days)
        if (curDate.isAfter(curCycle.startDate!) &&
            curDate.isBefore(curCycle.periodEndDate!)) {
          if (existingPeriodDay != null) {
            if (curDate == existingPeriodDay.date) {
              //Existing record is a periodDay that is not a start or end day; update flags as necessary
              PeriodDay updated = existingPeriodDay.copyWith(
                  isPeriodStartDay: false, isPeriodEndDay: false);
              await DatabaseHelper().updatePeriodDay(updated, txn: txn);
            }
          } else {
            if (existingDay == null) {
              PeriodDay newPeriodDay = PeriodDay(
                date: curDate,
                flowWeight: FlowWeight.none, // default
                isPeriodStartDay: false,
                isPeriodEndDay: false,
              );
              await DatabaseHelper().insertPeriodDay(newPeriodDay, txn: txn);
            } else {
              await DayEntryRepository.instance.updateDayToPeriodDay(
                PeriodDay(
                  date: curDate,
                  flowWeight: FlowWeight.none,
                  isPeriodStartDay: false,
                  isPeriodEndDay: false,
                ),
                txn,
              );
            }
          }
        }
        // ToDo -Add flag to process End days correctly if period is ongoing.
        // Process periodEndDays
        if (curDate == curCycle.periodEndDate &&
            curDate != curCycle.startDate) {
          if (existingPeriodDay != null) {
            if (!existingPeriodDay.isPeriodEndDay) {
              //Existing record is not a periodEndDay
              await DatabaseHelper().updatePeriodDay(
                  existingPeriodDay.copyWith(
                      isPeriodEndDay: true, isPeriodStartDay: false),
                  txn: txn);
            }
            //Existing record is a periodEndDay; do nothing
          } else {
            if (existingDay == null) {
              PeriodDay newPeriodDay = PeriodDay(
                date: curDate,
                flowWeight: FlowWeight.none, // default
                isPeriodStartDay: false,
                isPeriodEndDay: true,
              );
              await DatabaseHelper().insertPeriodDay(newPeriodDay, txn: txn);
            } else {
              await DayEntryRepository.instance.updateDayToPeriodDay(
                PeriodDay(
                  date: curDate,
                  flowWeight: FlowWeight.none,
                  isPeriodStartDay: false,
                  isPeriodEndDay: true,
                ),
                txn,
              );
            }
          }
        }
      }
    }

    //###### Process normal Days ######

    //If a Day is not a PeriodDay anymore, it should be deleted from the PeriodDay table
    if (deselecetedPeriodDates.isNotEmpty) {
      for (DateTime date in deselecetedPeriodDates) {
        await DatabaseHelper().deletePeriodDay(date, txn: txn);
      }
    }
    //The database helper class helps on deletion of a PeriodDay entry by marking the
    //corresponding Day table isPeriodDay flag to false.
    return true;
  }
}
