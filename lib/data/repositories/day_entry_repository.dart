import 'package:flutter/material.dart';
import 'package:mina_app/common/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mina_app/data/database/connection/shared.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/database/days_dao.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DayEntryRepository {
  final AppDatabase db;
  late final AppDaysDao _daysDao;

  DayEntryRepository(this.db) {
    _daysDao = db.appDaysDao;
  }
  Future<void> insertDayEntry(Day day, String userId) async {
    try {
      var dayResponse = await Supabase.instance.client
          .from('Days')
          .select()
          .eq('date', day.date.toIso8601String())
          .eq('user_id', userId);

//If no Day entry exists, insert a new Day entry
      if (dayResponse.isEmpty) {
        await Supabase.instance.client.from('Days').insert({
          'user_id': userId,
          'date': day.date.toIso8601String(),
          'isPeriodDay': day.isPeriodDay,
          'moodList': day.moodList != null ? day.moodList.toString() : '',
          'symptomList':
              day.symptomList != null ? day.symptomList.toString() : '',
          'note': day.note,
        });
      } else {
        await Supabase.instance.client.from('Days').update({
          'user_id': userId,
          'date': day.date.toIso8601String(),
          'isPeriodDay': day.isPeriodDay,
          'moodList': day.moodList != null ? day.moodList.toString() : '',
          'symptomList':
              day.symptomList != null ? day.symptomList.toString() : '',
          'note': day.note,
        }).eq('id', dayResponse[0]['id']);
      }
    } catch (e) {
      print('Error inserting Day entry: $e');
      throw Exception('Failed to insert Day entry');
    }
  }

  Future<void> insertPeriodDayEntry(PeriodDay periodDay, String userId) async {
    try {
      // Check if a PeriodDay entry exists for the given date and user
      var periodDayResponse = await Supabase.instance.client
          .from('PeriodDays')
          .select()
          .eq('date', periodDay.date.toIso8601String())
          .eq('user_id', userId);

      // If a PeriodDay entry exists, delete it
      if (periodDayResponse.isNotEmpty) {
        var periodDayId = periodDayResponse[0]['id'];
        await Supabase.instance.client
            .from('PeriodDays')
            .delete()
            .eq('id', periodDayId);

        await Supabase.instance.client
            .from('Days')
            .delete()
            .eq('date', periodDay.date.toIso8601String())
            .eq('user_id', userId);
      }

      // Find corresponding Day entry
      var dayResponse = await Supabase.instance.client
          .from('Days')
          .select()
          .eq('date', periodDay.date.toIso8601String())
          .eq('user_id', userId);

      if (dayResponse.isEmpty) {
        // Insert new Day entry if it doesn't exist
        await Supabase.instance.client.from('Days').insert({
          'user_id': userId,
          'date': periodDay.date.toIso8601String(),
          'isPeriodDay': true,
          'moodList':
              periodDay.moodList != null ? periodDay.moodList.toString() : '',
          'symptomList': periodDay.symptomList != null
              ? periodDay.symptomList.toString()
              : '',
          'note': periodDay.note,
        });
        // Fetch the newly created Day entry to get its id
        var newDayResponse = await Supabase.instance.client
            .from('Days')
            .select()
            .eq('date', periodDay.date.toIso8601String())
            .eq('user_id', userId);
        print('inserting PeriodDay entry: ${periodDay.toString()}');
        // Insert new PeriodDay entry
        await Supabase.instance.client.from('PeriodDays').insert({
          'user_id': userId,
          'date': periodDay.date.toIso8601String(),
          'flowWeight': periodDay.flowWeight.index,
          'isPeriodStartDay': periodDay.isPeriodStartDay,
          'isPeriodEndDay': periodDay.isPeriodEndDay,
          'day_id': newDayResponse[0]['id']
        });
      } else {
        //delete the Day entry if it exists
        await Supabase.instance.client
            .from('Days')
            .delete()
            .eq('date', periodDay.date.toIso8601String())
            .eq('user_id', userId);
        // Insert new Day entry to ensure isPeriodDay is true and update fields
        await Supabase.instance.client.from('Days').insert({
          'user_id': userId,
          'date': periodDay.date.toIso8601String(),
          'isPeriodDay': true,
          'moodList':
              periodDay.moodList != null ? periodDay.moodList.toString() : '',
          'symptomList': periodDay.symptomList != null
              ? periodDay.symptomList.toString()
              : '',
          'note': periodDay.note,
        });
        // Fetch the newly created Day entry to get its idz
        var newDayResponse = await Supabase.instance.client
            .from('Days')
            .select()
            .eq('date', periodDay.date.toIso8601String())
            .eq('user_id', userId);
        print('inserting PeriodDay entry: ${periodDay.toString()}');
        // Insert new PeriodDay entry
        await Supabase.instance.client.from('PeriodDays').insert({
          'user_id': userId,
          'date': periodDay.date.toIso8601String(),
          'flowWeight': periodDay.flowWeight.index,
          'isPeriodStartDay': periodDay.isPeriodStartDay,
          'isPeriodEndDay': periodDay.isPeriodEndDay,
          'day_id': newDayResponse[0]['id']
        });
      }
    } catch (e) {
      print('Error inserting PeriodDay entry: $e');
      throw Exception('Failed to insert PeriodDay entry');
    }
  }

  Future<List<Day>> getDaysInRange(
      DateTime firstDayOfPrevMonth, DateTime lastDayOfNextMonth) async {
    try {
      return await Supabase.instance.client
          .from('Days')
          .select()
          .gte('date', firstDayOfPrevMonth.toIso8601String())
          .lte('date', lastDayOfNextMonth.toIso8601String())
          .order('date', ascending: true)
          .then((response) {
        if (response == null || response.isEmpty) {
          return [];
        }

        // Assuming fromJson is a factory constructor for Day
        var days = (response).map((json) => Day.fromMap(json)).toList();

        return days;
      });

      /*  return await _daysDao.getDaysInRange(
          firstDayOfPrevMonth, lastDayOfNextMonth); */
    } catch (e) {
      // Log the error and rethrow a custom exception
      print('Error retrieving Days in range: $e');
      throw Exception('Failed to retrieve Days in range');
    }
  }

  Future<List<PeriodDay>> getPeriodDaysInRange(
      DateTime startDate, DateTime endDate, String userId) async {
    try {
      return await Supabase.instance.client
          .from('PeriodDays')
          .select()
          .gte('date', startDate.toIso8601String())
          .lte('date', endDate.toIso8601String())
          .eq('user_id', userId)
          .order('date', ascending: true)
          .then((response) {
        if (response == null || response.isEmpty) {
          return [];
        }
        var periodDays = (response)
            .map((json) => PeriodDay.fromMap(json as Map<String, dynamic>))
            .toList();

        return periodDays;
      });

      //await _daysDao.getPeriodDaysInRange(startDate, endDate, userId);
    } catch (e) {
      print('Error retrieving PeriodDays in range: $e');
      throw Exception('Failed to retrieve PeriodDays in range');
    }
  }

  Future<Day?> getDayEntry(DateTime date, String userId) async {
    try {
      // Fetch Day entry with inner join on PeriodDays
      List<dynamic> response = await Supabase.instance.client
          .from('Days')
          .select('*, PeriodDays(*)')
          .eq('date', date.toIso8601String())
          .eq('user_id', userId)
          .limit(1);

      if (response == null || response.isEmpty) {
        return null;
      }
      print('DayEntryRepository: getDayEntry response: $response');
      Map<String, dynamic> dayData = response[0] as Map<String, dynamic>;

      // If isPeriodDay is true and PeriodDays data exists, map to PeriodDay
      if (dayData['isPeriodDay'] == true && dayData['PeriodDays'] != null) {
        var periodDaysList = dayData['PeriodDays'];
        Map<String, dynamic> periodDayMap =
            periodDaysList[0] as Map<String, dynamic>;
        if (periodDaysList is List && periodDaysList.isNotEmpty) {
          periodDayMap.addAll(Map<String, dynamic>.from(dayData));
          print('PeriodDays data found: $periodDayMap');
        }
        return PeriodDay.fromMap(periodDayMap);
      } else {
        return Day.fromMap(dayData);
      }
    } catch (e) {
      debugPrint('Error retrieving Day entry: $e');
      throw Exception('Failed to retrieve Day entry');
    }
  }

  Future<PeriodDay?> getPeriodDayEntry(DateTime date, String userId) async {
    try {
      return Supabase.instance.client
          .from('PeriodDays')
          .select()
          .eq('date', date.toIso8601String())
          .eq('user_id', userId)
          .maybeSingle()
          .then((response) {
        if (response == null) {
          return null;
        }

        return PeriodDay.fromMap(response as Map<String, dynamic>);
      });
      //var periodDay = await _daysDao.getPeriodDay(date, userId);
    } catch (e) {
      print('Error retrieving PeriodDay entry: $e');
      throw Exception('Failed to retrieve PeriodDay entry');
    }
  }

  Future<List<Day>> getCombinedDayAndPeriodDayRecords(String userId) async {
    // Fetch Days and PeriodDays from Supabase
    var daysResponse = await Supabase.instance.client
        .from('Days')
        .select()
        .eq('user_id', userId);

    var periodDaysResponse = await Supabase.instance.client
        .from('PeriodDays')
        .select()
        .eq('user_id', userId);

    // Convert responses to maps for easier lookup
    var periodDaysMap = {for (var pd in periodDaysResponse) pd['date']: pd};

    List<Day> result = [];

    for (var day in daysResponse) {
      var dateStr = day['date'] as String;
      var periodDay = periodDaysMap[dateStr];

      if (day['isPeriodDay'] == true && periodDay != null) {
        // Map to PeriodDay model
        result.add(PeriodDay(
          date: DateTime.parse(dateStr),
          note: day['note'] as String?,
          symptomList: day['symptomList'] != null
              ? SymptomList.fromString(day['symptomList'] as String?)
              : null,
          moodList: day['moodList'] != null
              ? MoodList.fromString(day['moodList'] as String?)
              : null,
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
          symptomList: day['symptomList'] != null
              ? SymptomList.fromString(day['symptomList'] as String?)
              : null,
          moodList: day['moodList'] != null
              ? MoodList.fromString(day['moodList'] as String?)
              : null,
        ));
      }
    }

    // Sort by date ascending
    result.sort((a, b) => a.date.compareTo(b.date));
    return result;
  }

  Future<List<Day>> getAllDaysandPeriodDays(String userId) async {
    try {
      var result = await getCombinedDayAndPeriodDayRecords(userId);
      return result;
    } catch (e) {
      print('Error retrieving all Days and PeriodDays: $e');
      throw Exception('Failed to retrieve all Days and PeriodDays');
    }
  }

  Future<int> deleteDayEntry(DateTime date, String userId) async {
    try {
      return await Supabase.instance.client
          .from('Days')
          .delete()
          .eq('date', date.toIso8601String())
          .eq('user_id', userId)
          .then((response) {
        if (response == null) {
          throw Exception(
              'Failed to delete Day entry: ${response.error!.message}');
        }
        return response.data.length; // Return the number of deleted rows
      });
      // return await _daysDao.deleteDay(date, userId);
    } catch (e) {
      print('Error deleting Day entry: $e');
      throw Exception('Failed to delete Day entry');
    }
  }

  Future<void> deletePeriodDayEntry(DateTime date, String userId) async {
    try {
      await Supabase.instance.client
          .from('PeriodDays')
          .delete()
          .eq('date', date.toIso8601String())
          .eq('user_id', userId)
          .then((response) {
        if (response != null) {
          throw Exception('Failed to delete PeriodDay entry: $response');
        }
      });
      await Supabase.instance.client
          .from('Days')
          .update({'isPeriodDay': false})
          .eq('date', date.toIso8601String())
          .eq('user_id', userId);
    } catch (e) {
      debugPrint('Error deleting PeriodDay entry: $e');
      throw Exception('Failed to delete PeriodDay entry');
    }
  }

//update Day to a PeriodDay
  Future<void> updateDayToPeriodDay(PeriodDay periodDay, String userId) async {
    try {
      await Supabase.instance.client
          .from('PeriodDays')
          .update({
            'date': periodDay.date.toIso8601String(),
            'flowWeight': periodDay.flowWeight.index,
            'isPeriodStartDay': periodDay.isPeriodStartDay,
            'isPeriodEndDay': periodDay.isPeriodEndDay,
          })
          .eq('date', periodDay.date.toIso8601String())
          .eq('user_id', userId);
      //  await _daysDao.updateDayToPeriodDay(periodDay, txn: txn);
    } catch (e) {
      // Log the error and rethrow a custom exception
      print('Error updating Day to PeriodDay: $e');
      throw Exception('Failed to update Day to PeriodDay');
    }
  }

// NEW: Add updateDay method
  Future<void> updateDayEntry(Day day, String userId) async {
    try {
      // Update the Day entry in Supabase
      await Supabase.instance.client
          .from('Days')
          .upsert({
            'note': day.note,
            'symptomList': day.symptomList.toString(),
            'moodList': day.moodList.toString(),
            'isPeriodDay': day.isPeriodDay,
          })
          .eq('date', day.date.toIso8601String())
          .eq('user_id', userId);

      if (!day.isPeriodDay) {
        // If changed from PeriodDay to non-PeriodDay, delete from PeriodDays
        await Supabase.instance.client
            .from('PeriodDays')
            .delete()
            .eq('date', day.date.toIso8601String())
            .eq('user_id', userId);
      }
    } catch (e) {
      print('Error updating Day entry: $e');
      throw Exception('Failed to update Day entry');
    }
  }

// NEW: Add updatePeriodDay method
  Future<void> updatePeriodDayEntry(PeriodDay periodDay, String userId) async {
    try {
      var periodDayMap = periodDay.toPeriodDayMap();
      periodDayMap['user_id'] = userId;
      await Supabase.instance.client
          .from('PeriodDays')
          .update(periodDayMap)
          .eq('date', periodDay.date.toIso8601String())
          .eq('user_id', userId);
    } catch (e) {
      print('Error updating PeriodDay entry: $e');
      throw Exception('Failed to update PeriodDay entry');
    }
  }

  Future<dynamic> fetchDayEntry(DateTime date, String userId) async {
    try {
      var response = await Supabase.instance.client
          .from('Days')
          .select('*, PeriodDays(*)')
          .eq('date', Utils().normalizedDate(date).toIso8601String())
          .eq('user_id', userId)
          .maybeSingle();
      return response;
    } catch (e) {
      // Handle or log the error as needed
      print('Error fetching day entry: $e');
      return null;
    }
  }
}
