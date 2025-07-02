import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mina_app/common/utils.dart';
import 'package:mina_app/data/database/connection/shared.dart';
import 'package:mina_app/data/database/cycle_dao.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/model/symptom_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CycleRepository {
  late final AppDatabase database;
  late final AppCyclesDao _cyclesDao;

  CycleRepository(this.database) {
    _cyclesDao = AppCyclesDao(database);
  }
  Future<Cycle?> getPresentCycle(String userId) async {
    final globalCycle = await Supabase.instance.client
        .from('Cycles')
        .select()
        .eq('user_id', userId)
        .order('startDate', ascending: false)
        .limit(1)
        .single();
    if (globalCycle != null && globalCycle is List && globalCycle.isNotEmpty) {
      final cycleData = globalCycle;
      return Cycle(
        userId: cycleData['user_id'] as String,
        startDate: DateTime.parse(cycleData['start_date'] as String),
        endDate: cycleData['end_date'] != null
            ? DateTime.parse(cycleData['end_date'] as String)
            : null,
        periodEndDate: cycleData['period_end_date'] != null
            ? DateTime.parse(cycleData['period_end_date'] as String)
            : null,
        // Add other fields as needed
      );
    }
    return null;
    //final Cycle? globalCycle = await _cyclesDao.getPresentCycle(userId);
  }

  Future<Cycle?> getCycleByStartDate(DateTime startDate, String userId) async {
    final response = await Supabase.instance.client
        .from('Cycles')
        .select()
        .eq('user_id', userId)
        .eq('start_date', startDate.toIso8601String())
        .maybeSingle();

    if (response != null) {
      final cycleData = response;
      final cycle = Cycle(
        userId: cycleData['user_id'] as String,
        startDate: DateTime.parse(cycleData['start_date'] as String),
        endDate: cycleData['end_date'] != null
            ? DateTime.parse(cycleData['end_date'] as String)
            : null,
        periodEndDate: cycleData['period_end_date'] != null
            ? DateTime.parse(cycleData['period_end_date'] as String)
            : null,
        // Add other fields as needed
      );
      return cycle;
    }
    return null;
  }

  Future<List<Day>> getCombinedDayAndPeriodDayRecords(String userId) async {
    // Fetch Days and PeriodDays from Supabase
    final daysResponse = await Supabase.instance.client
        .from('Days')
        .select()
        .eq('user_id', userId);

    final periodDaysResponse = await Supabase.instance.client
        .from('PeriodDays')
        .select()
        .eq('user_id', userId);

    // Convert responses to maps for easier lookup
    final periodDaysMap = {for (var pd in periodDaysResponse) pd['date']: pd};

    List<Day> result = [];

    for (var day in daysResponse) {
      final dateStr = day['date'] as String;
      final periodDay = periodDaysMap[dateStr];

      if (day['isPeriodDay'] == true && periodDay != null) {
        // Map to PeriodDay model
        result.add(PeriodDay(
          date: DateTime.parse(dateStr),
          note: day['note'] as String?,
          symptomList: SymptomList.fromString(day['symptomList'] as String?),
          moodList: MoodList.fromString(day['moodList'] as String?),
          flowWeight: periodDay['flowWeight'] != null
              ? FlowWeight.values[periodDay['flowWeight'] as int]
              : FlowWeight.none,
          isPeriodStartDay: periodDay['isPeriodStartDay'] == true,
          isPeriodEndDay: periodDay['isPeriodEndDay'] == true,
        ));
      } else {
        // Map to Day model
        result.add(Day(
          date: DateTime.parse(dateStr),
          isPeriodDay: day['isPeriodDay'] == true,
          note: day['note'] as String?,
          symptomList: SymptomList.fromString(day['symptomList'] as String?),
          moodList: MoodList.fromString(day['moodList'] as String?),
        ));
      }
    }

    // Sort by date ascending
    result.sort((a, b) => a.date.compareTo(b.date));
    return result;
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
      final days = await getCombinedDayAndPeriodDayRecords(userId);

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
      //await _cyclesDao.insertCycle(cycle, userId);
      await Supabase.instance.client.from('Cycles').insert({
        'user_id': userId,
        'startDate':
            cycle.startDate != null ? cycle.startDate?.toIso8601String() : '',
        'endDate':
            cycle.endDate != null ? cycle.endDate?.toIso8601String() : '',
        'periodEndDate': cycle.periodEndDate != null
            ? cycle.periodEndDate?.toIso8601String()
            : '',
      });
    } catch (e) {
      debugPrint('Error inserting cycle: $e');
      throw Exception('Failed to insert cycle');
    }
  }

  Future<List<Cycle>> getCycles(String userId) async {
    try {
      //final appCycles = await _cyclesDao.getAllCycles(userId);
      final cycles = await Supabase.instance.client
          .from('Cycles')
          .select()
          .eq('user_id', userId)
          .order('startDate', ascending: false);
      // Map AppCycle to Cycle
      return cycles
          .map((cycle) => Cycle(
                userId: cycle['user_id'],
                startDate: DateTime.parse(cycle['startDate']),
                endDate: DateTime.parse(cycle['endDate']),
                periodEndDate: DateTime.parse(cycle['periodEndDate']),
              ))
          .toList();
    } catch (e) {
      debugPrint('Error retrieving cycles: $e');
      throw Exception('Failed to retrieve cycles');
    }
  }

  Future<void> updateCycle(int id, Cycle cycle, String userId) async {
    try {
      //await _cyclesDao.updateCycle(id, cycle, userId);
      await Supabase.instance.client.from('Cycles').update({
        'startDate': cycle.startDate?.toIso8601String(),
        'endDate': cycle.endDate?.toIso8601String(),
        'periodEndDate': cycle.periodEndDate?.toIso8601String(),
      }).eq('id', id);
    } catch (e) {
      debugPrint('Error updating cycle: $e');
      throw Exception('Failed to update cycle');
    }
  }

  Future<void> deleteCycle(int id, String userId) async {
    try {
      await Supabase.instance.client
          .from('Cycles')
          .delete()
          .eq('id', id); //_cyclesDao.deleteCycle(id, userId);
    } catch (e) {
      debugPrint('Error deleting cycle: $e');
      throw Exception('Failed to delete cycle');
    }
  }

  Future<Cycle?> getCycle(DateTime date, String userId) async {
    // Normalize the date for comparison
    final normalizedDate = Utils().normalizedDate(date);

    // Query Supabase for a cycle containing the given date
    final response = await Supabase.instance.client
        .from('Cycles')
        .select()
        .eq('user_id', userId)
        .lte('startDate', normalizedDate.toIso8601String())
        .gte('endDate', normalizedDate.toIso8601String())
        .maybeSingle();

    if (response != null) {
      return Cycle(
        userId: response['user_id'] as String,
        startDate: DateTime.parse(response['startDate'] as String),
        endDate: response['endDate'] != null
            ? DateTime.parse(response['endDate'] as String)
            : null,
        periodEndDate: response['periodEndDate'] != null
            ? DateTime.parse(response['periodEndDate'] as String)
            : null,
        // Add other fields as needed
      );
    }
/* 
    // Use the DAO to query for a cycle containing the given date
    final appCycle = await _cyclesDao.getCycleByDate(normalizedDate, userId);

    if (appCycle != null) {
      return Cycle(
        userId: appCycle.userId,
        startDate: appCycle.startDate,
        endDate: appCycle.endDate,
        periodEndDate: appCycle.periodEndDate,
        // Add other fields as needed
      ); */
    else {
      return null;
    }
  }
}
