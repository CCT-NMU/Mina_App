import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mina_app/common/utils.dart';
import 'package:mina_app/data/database/connection/shared.dart';
import 'package:mina_app/data/database/cycle_dao.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/model/period_day.dart';

class CycleRepository {
  late final AppDatabase database;
  late final AppCyclesDao _cyclesDao;

  CycleRepository._privateConstructor() {
    database = constructDb();
    _cyclesDao = AppCyclesDao(database);
  }
  static final CycleRepository _instance =
      CycleRepository._privateConstructor();
  static CycleRepository get instance => _instance;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<Cycle?> getPresentCycle(String userId) async {
    final Cycle? globalCycle = await _cyclesDao.getPresentCycle(userId);

    return globalCycle;
  }

  Future<Cycle?> getCycleByStartDate(DateTime startDate, String userId) async {
    final Cycle? cycle =
        await _cyclesDao.getCycleByStartDate(startDate, userId);

    return cycle;
  }

//
  /// Calculates the menstrual cycle history by evaluating the list of days
  /// which includes both regular days and period days.
  ///
  /// This function retrieves all day records from the database, sorts them by date,
  /// and identifies the start and end of each menstrual cycle to build a list of
  /// `Cycle` objects. Each cycle's start date is marked by a `PeriodDay` with
  /// `isPeriodStartDay` set to true, and the cycle ends the day before the next
  /// start day. If a cycle is ongoing without a defined end, the current date is
  /// used as the cycle's end date.
  ///
  /// Returns a list of `Cycle` objects representing each identified cycle.
  /// If an error occurs during processing, an empty list is returned.

  Future<List<Cycle>> calculateCycleHistory(String userId) async {
    try {
      List<Cycle> cycles = [];
      final days = await _dbHelper.getCombinedDayAndPeriodDayRecords(userId);

      // Sort days by date to ensure proper order
      days.sort((a, b) => a.date.compareTo(b.date));

      DateTime? currentStartDate;
      int? currentPeriodLength;

      for (int i = 0; i < days.length; i++) {
        final day = days[i];
        if (day is PeriodDay) {
          // If we find a start day, mark it
          if (day.isPeriodStartDay) {
            // If we had a previous cycle, we can now calculate its end date
            if (currentStartDate != null) {
              cycles.add(Cycle(
                userId: userId,
                startDate: currentStartDate,
                endDate: day.date.subtract(const Duration(
                    days: 1)), // End date is day before next start
                periodEndDate: day.date,
              ));
            }
            currentStartDate = day.date;
            currentPeriodLength = 0;
          }

          // Count period length until we find an end day
          if (currentStartDate != null) {
            currentPeriodLength = (currentPeriodLength ?? 0) + 1;
          }
        }
      }

      // Handle the last cycle if we have one
      if (currentStartDate != null) {
        // For the last cycle, end date is today if we don't have a next start date
        final endDate = DateTime.now();
        cycles.add(Cycle(
          userId: userId,
          startDate: currentStartDate,
          endDate: endDate,
          periodEndDate: endDate,
        ));
      }

      return cycles;
    } catch (e) {
      debugPrint('Error calculating cycle history: $e');
      return [];
    }
  }

  Future<int> calculateAvgCycleLength(String userId) async {
    try {
      final cycles = await calculateCycleHistory(userId);
      if (cycles.isEmpty || cycles.length < 2) return 0;

      int totalLength = 0;
      for (int i = 0; i < cycles.length - 1; i++) {
        totalLength +=
            cycles[i + 1].startDate!.difference(cycles[i].startDate!).inDays;
      }

      return totalLength ~/ (cycles.length - 1);
    } catch (e) {
      debugPrint('Error calculating average cycle length: $e');
      return 0;
    }
  }

  Future<int> calculateAvgPeriodLength(String userId) async {
    try {
      final cycles = await calculateCycleHistory(userId);
      if (cycles.isEmpty) return 0;

      int totalLength = 0;
      int validCycles = 0;

      for (var cycle in cycles) {
        if (cycle.periodEndDate != null && cycle.startDate != null) {
          if (cycle.startDate!.difference(cycle.periodEndDate!) >
              Duration.zero) {
            totalLength +=
                cycle.startDate!.difference(cycle.periodEndDate!).inDays;
            validCycles++;
          }
        }
      }

      return validCycles > 0 ? totalLength ~/ validCycles : 0;
    } catch (e) {
      debugPrint('Error calculating average period length: $e');
      return 0;
    }
  }

  Future<DateTime?> predictNextPeriod(String userId) async {
    try {
      final cycles = await calculateCycleHistory(userId);
      if (cycles.isEmpty) return null;

      final avgCycleLength = await calculateAvgCycleLength(userId);
      if (avgCycleLength == 0) return null;

      final lastPeriod = cycles.last;
      return lastPeriod.startDate!.add(Duration(days: avgCycleLength));
    } catch (e) {
      debugPrint('Error predicting next period: $e');
      return null;
    }
  }

  // Additional methods for cycle CRUD operations using database helper

  Future<void> insertCycle(Cycle cycle, String userId) async {
    try {
      await _cyclesDao.insertCycle(cycle, userId);
    } catch (e) {
      debugPrint('Error inserting cycle: $e');
      throw Exception('Failed to insert cycle');
    }
  }

  Future<List<Cycle>> getCycles(String userId) async {
    try {
      final appCycles = await _cyclesDao.getAllCycles(userId);
      // Map AppCycle to Cycle
      return appCycles
          .map((appCycle) => Cycle(
                userId: appCycle.userId,
                startDate: appCycle.startDate,
                endDate: appCycle.endDate,
                periodEndDate: appCycle.periodEndDate,
                // Add other fields as needed
              ))
          .toList();
    } catch (e) {
      debugPrint('Error retrieving cycles: $e');
      throw Exception('Failed to retrieve cycles');
    }
  }

  Future<void> updateCycle(int id, Cycle cycle, String userId) async {
    try {
      await _cyclesDao.updateCycle(id, cycle, userId);
    } catch (e) {
      debugPrint('Error updating cycle: $e');
      throw Exception('Failed to update cycle');
    }
  }

  Future<void> deleteCycle(int id, String userId) async {
    try {
      await _cyclesDao.deleteCycle(id, userId);
    } catch (e) {
      debugPrint('Error deleting cycle: $e');
      throw Exception('Failed to delete cycle');
    }
  }

  Future<Cycle?> getCycle(DateTime date, String userId) async {
    // Normalize the date for comparison
    final normalizedDate = Utils().normalizedDate(date);

    // Use the DAO to query for a cycle containing the given date
    final appCycle = await _cyclesDao.getCycleByDate(normalizedDate, userId);

    if (appCycle != null) {
      return Cycle(
        userId: appCycle.userId,
        startDate: appCycle.startDate,
        endDate: appCycle.endDate,
        periodEndDate: appCycle.periodEndDate,
        // Add other fields as needed
      );
    } else {
      return null;
    }
  }
}
