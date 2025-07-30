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

  Future<void> insertOrUpdatePeriodDayEntry(
      PeriodDay periodDay, String userUuid) async {
    try {
      // 1. Upsert Day entry (ensures day exists)
      await Supabase.instance.client.from('day').upsert({
        'user_id': userUuid,
        'date': periodDay.date.toIso8601String(),
        'is_period_day': true,
        'mood_list': periodDay.moodList?.toString() ?? '',
        'symptom_list': periodDay.symptomList?.toString() ?? '',
        'note': periodDay.note ?? "",
      }, onConflict: 'user_id,date');

      // 2. Get the day.id for this date/user
      final dayRows = await Supabase.instance.client
          .from('day')
          .select('id')
          .eq('user_id', userUuid)
          .eq('date', periodDay.date.toIso8601String());

      if (dayRows == null || dayRows.isEmpty) {
        throw Exception('Failed to find or create Day entry');
      }
      final dayId = dayRows[0]['id'];

      // 3. Upsert PeriodDay entry (use onConflict for (day_id) or (user_id,date) if you have a unique constraint)
      await Supabase.instance.client.from('period_day').upsert({
        'date': periodDay.date.toIso8601String(),
        'flow_weight': periodDay.flowWeight.index,
        'is_period_start_day': periodDay.isPeriodStartDay,
        'is_period_end_day': periodDay.isPeriodEndDay,
        'day_id': dayId,
        'user_id': userUuid,
      }, onConflict: 'day_id');
    } catch (e) {
      print('Error inserting/updating PeriodDay entry: $e');
      throw Exception('Failed to insert or update PeriodDay entry');
    }
  }

  Future<void> insertDayEntry(Day day, String userUuid) async {
    try {
      var dayResponse = await Supabase.instance.client
          .from('day')
          .select()
          .eq('date', day.date.toIso8601String())
          .eq('user_id', userUuid);

      if (dayResponse.isEmpty) {
        await Supabase.instance.client.from('day').insert({
          'user_id': userUuid,
          'date': day.date.toIso8601String(),
          'is_period_day': day.isPeriodDay ? 1 : 0,
          'mood_list': day.moodList != null ? day.moodList.toString() : '',
          'symptom_list':
              day.symptomList != null ? day.symptomList.toString() : '',
          'note': day.note,
        });
      } else {
        await Supabase.instance.client.from('day').update({
          'user_id': userUuid,
          'date': day.date.toIso8601String(),
          'is_period_day': day.isPeriodDay ? 1 : 0,
          'mood_list': day.moodList != null ? day.moodList.toString() : '',
          'symptom_list':
              day.symptomList != null ? day.symptomList.toString() : '',
          'note': day.note,
        }).eq('id', dayResponse[0]['id']);
      }
    } catch (e) {
      print('Error inserting Day entry: $e');
      throw Exception('Failed to insert Day entry');
    }
  }

//must insert a period day
//A] if a period day entry exists already update the period day entry

//1] if a day entry already exists reference the day_id
//2] if a day entry does not exist create a new day entry
  Future<void> insertPeriodDayEntry(
      PeriodDay periodDay, String userUuid) async {
    try {
      // Check if a PeriodDay entry exists for the given date and user
      var periodDayResponse = await Supabase.instance.client
          .from('period_day')
          .select()
          .eq('date', periodDay.date.toIso8601String())
          .eq('user_id', userUuid);

      // If a PeriodDay entry exists, update it
      if (periodDayResponse.isNotEmpty) {
        updatePeriodDayEntry(periodDay, userUuid);
        /*      var periodDayId = periodDayResponse[0]['id'];
        await Supabase.instance.client
            .from('period_day')
            .delete()
            .eq('id', periodDayId); */
      } else {
        // Find corresponding Day entry
        var dayResponse = await Supabase.instance.client
            .from('day')
            .select()
            .eq('date', periodDay.date.toIso8601String())
            .eq('user_id', userUuid);

        if (dayResponse.isEmpty) {
          // Insert new Day entry if it doesn't exist
          await Supabase.instance.client.from('day').insert({
            'user_id': userUuid,
            'date': periodDay.date.toIso8601String(),
            'is_period_day': true,
            'mood_list':
                periodDay.moodList != null ? periodDay.moodList.toString() : '',
            'symptom_list': periodDay.symptomList != null
                ? periodDay.symptomList.toString()
                : '',
            'note': periodDay.note ?? "",
          });
          // Fetch the newly created Day entry to get its id
          var newDayResponse = await Supabase.instance.client
              .from('day')
              .select()
              .eq('date', periodDay.date.toIso8601String())
              .eq('user_id', userUuid);
          print('inserting PeriodDay entry: ${periodDay.toString()}');

          // Insert new PeriodDay entry
          await Supabase.instance.client.from('period_day').insert({
            'date': periodDay.date.toIso8601String(),
            'flow_weight': periodDay.flowWeight.index,
            'is_period_start_day': periodDay.isPeriodStartDay ? 1 : 0,
            'is_period_end_day': periodDay.isPeriodEndDay ? 1 : 0,
            'day_id': newDayResponse[0]['id']
          });
        } else {
          // Insert new PeriodDay entry
          await Supabase.instance.client.from('period_day').insert({
            'date': periodDay.date.toIso8601String(),
            'flow_weight': periodDay.flowWeight.index,
            'is_period_start_day': periodDay.isPeriodStartDay ? 1 : 0,
            'is_period_end_day': periodDay.isPeriodEndDay ? 1 : 0,
            'day_id': dayResponse[0]['id']
          });

          // Update the Day entry to mark it as a period day
          await Supabase.instance.client.from('day').update({
            'is_period_day': true,
          });
        }
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
          .from('day')
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
          .from('period_day')
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
          .from('day')
          .select('*, period_day(*)')
          .eq('date', date.toIso8601String())
          .eq('user_id', userId)
          .limit(1);

      if (response == null || response.isEmpty) {
        return null;
      }
      print('DayEntryRepository: getDayEntry response: $response');
      Map<String, dynamic> dayData = response[0] as Map<String, dynamic>;

      // If is_period_day is true and period_days data exists, map to PeriodDay
      if (dayData['is_period_day'] == true && dayData['period_days'] != null) {
        var periodDaysData = dayData['period_days'];
        Map<String, dynamic> periodDayMap;

        if (periodDaysData is Map<String, dynamic>) {
          periodDayMap = Map<String, dynamic>.from(periodDaysData);
        } else {
          // Unexpected structure, fallback to Day
          return Day.fromMap(dayData);
        }

        // Optionally merge dayData fields if needed
        periodDayMap.addAll(Map<String, dynamic>.from(dayData));
        print('PeriodDays data found: $periodDayMap');
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
          .from('period_day')
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
        .from('day')
        .select()
        .eq('user_id', userId);

    var periodDaysResponse = await Supabase.instance.client
        .from('period_day')
        .select()
        .eq('user_id', userId);

    // Convert responses to maps for easier lookup
    var periodDaysMap = {for (var pd in periodDaysResponse) pd['date']: pd};

    List<Day> result = [];

    for (var day in daysResponse) {
      var dateStr = day['date'] as String;
      var periodDay = periodDaysMap[dateStr];

      if (day['is_period_day'] == true && periodDay != null) {
        // Map to PeriodDay model
        result.add(PeriodDay(
          date: DateTime.parse(dateStr),
          note: day['note'] as String?,
          symptomList: day['symptom_list'] != null
              ? SymptomList.fromString(day['symptom_list'] as String?)
              : null,
          moodList: day['mood_list'] != null
              ? MoodList.fromString(day['mood_list'] as String?)
              : null,
          flowWeight: periodDay['flow_weight'] != null
              ? FlowWeight.values[periodDay['flow_weight'] as int]
              : FlowWeight.none,
          isPeriodStartDay: periodDay['is_period_start_day'] == true,
          isPeriodEndDay: periodDay['is_period_end_day'] == true,
        ));
      } else {
        // Map to Day model
        result.add(Day(
          date: DateTime.parse(dateStr),
          isPeriodDay: day['is_period_day'] == true,
          note: day['note'] as String?,
          symptomList: day['symptom_list'] != null
              ? SymptomList.fromString(day['symptom_list'] as String?)
              : null,
          moodList: day['mood_list'] != null
              ? MoodList.fromString(day['mood_list'] as String?)
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
          .from('day')
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
          .from('period_day')
          .delete()
          .eq('date', date.toIso8601String())
          .eq('user_id', userId)
          .then((response) {
        if (response != null) {
          throw Exception('Failed to delete PeriodDay entry: $response');
        }
      });
      await Supabase.instance.client
          .from('day')
          .update({'is_period_day': false})
          .eq('date', date.toIso8601String())
          .eq('user_id', userId);
    } catch (e) {
      debugPrint('Error deleting PeriodDay entry: $e');
      throw Exception('Failed to delete PeriodDay entry');
    }
  }

//update Day to a PeriodDay
  /// Updates a Day entry to a PeriodDay entry in the database.
  ///
  /// Takes a [PeriodDay] object and the [userId] of the user, updates the corresponding
  /// Day entry to mark it as a period day, and inserts a new PeriodDay entry.
  Future<void> updateDayToPeriodDay(PeriodDay periodDay, String userId) async {
    try {
      await Supabase.instance.client
          .from('day')
          .upsert({
            'is_period_day': true,
            'note': periodDay.note,
            'symptom_list': periodDay.symptomList != null
                ? periodDay.symptomList.toString()
                : '',
            'mood_list':
                periodDay.moodList != null ? periodDay.moodList.toString() : '',
          })
          .eq('date', periodDay.date.toIso8601String())
          .eq('user_id', userId);

      var result = await Supabase.instance.client
          .from('day')
          .select()
          .eq('date', periodDay.date.toIso8601String())
          .eq('user_id', userId);

      if (result != null && result.isNotEmpty) {
        await Supabase.instance.client
            .from('period_day')
            .upsert({
              'date': periodDay.date.toIso8601String(),
              'flow_weight': periodDay.flowWeight.index,
              'is_period_start_day': periodDay.isPeriodStartDay,
              'is_period_end_day': periodDay.isPeriodEndDay,
              'day_id': result[0]['id'],
            })
            .eq('date', periodDay.date.toIso8601String())
            .eq('user_id', userId);
      } else {
        throw Exception('No Day entry found for the given date and user.');
      }
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
          .from('day')
          .upsert({
            'note': day.note,
            'symptom_list': day.symptomList.toString(),
            'mood_list': day.moodList.toString(),
            'is_period_day': day.isPeriodDay,
          })
          .eq('date', day.date.toIso8601String())
          .eq('user_id', userId);

      if (!day.isPeriodDay) {
        // If changed from PeriodDay to non-PeriodDay, delete from period_day
        await Supabase.instance.client
            .from('period_day')
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
          .from('period_day')
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
          .from('day')
          .select('*, period_day(*)')
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
