import 'package:flutter/material.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/model/model.dart';
import 'package:sqflite/sqflite.dart';

class DayEntryRepository {
  DayEntryRepository._privateConstructor();
  static final DayEntryRepository _instance =
      DayEntryRepository._privateConstructor();
  static DayEntryRepository get instance => _instance;

  Future<void> insertDayEntry(Day day, String userId) async {
    try {
      await DatabaseHelper().insertDay(day, userId);
    } catch (e) {
      print('Error inserting Day entry: $e');
      throw Exception('Failed to insert Day entry');
    }
  }

  Future<void> insertPeriodDayEntry(
      PeriodDay periodDay, String userId, Transaction? txn) async {
    try {
      await DatabaseHelper().insertPeriodDay(periodDay, userId,
          txn: txn); //method handles the insertion in
      //both Day table and PeriodDay table.
    } catch (e) {
      print('Error inserting PeriodDay entry: $e');
      throw Exception('Failed to insert PeriodDay entry');
    }
  }

  getPeriodDaysInRange(
      DateTime startDate, DateTime endDate, String userId) async {
    try {
      return await DatabaseHelper()
          .getPeriodDaysInRange(startDate, endDate, userId);
    } catch (e) {
      print('Error retrieving PeriodDays in range: $e');
      throw Exception('Failed to retrieve PeriodDays in range');
    }
  }

  Future<Day?> getDayEntry(DateTime date, String userId) async {
    try {
      var day = await DatabaseHelper().getDay(date, userId);
      return day;
    } catch (e) {
      print('Error retrieving Day entry: $e');
      throw Exception('Failed to retrieve Day entry');
    }
  }

  Future<List<Day>> getAllDaysandPeriodDays(String userId) async {
    try {
      final result =
          await DatabaseHelper().getCombinedDayAndPeriodDayRecords(userId);
      return result;
    } catch (e) {
      print('Error retrieving all Days and PeriodDays: $e');
      throw Exception('Failed to retrieve all Days and PeriodDays');
    }
  }

  Future<int> deleteDayEntry(DateTime date, String userId) async {
    try {
      return await DatabaseHelper().deleteDayEntry(date, userId);
    } catch (e) {
      print('Error deleting Day entry: $e');
      throw Exception('Failed to delete Day entry');
    }
  }

  Future<int> deletePeriodDayEntry(DateTime date, String userId) async {
    try {
      return await DatabaseHelper().deletePeriodDay(date, userId);
    } catch (e) {
      debugPrint('Error deleting PeriodDay entry: $e');
      throw Exception('Failed to delete PeriodDay entry');
    }
  }

  Future<List<Day>> getDaysInRange(
      DateTime firstDayOfPrevMonth, DateTime lastDayOfNextMonth) async {
    try {
      return await DatabaseHelper()
          .getDaysInRange(firstDayOfPrevMonth, lastDayOfNextMonth);
    } catch (e) {
      // Log the error and rethrow a custom exception
      print('Error retrieving Days in range: $e');
      throw Exception('Failed to retrieve Days in range');
    }
  }

  //update Day to a PeriodDay
  Future<void> updateDayToPeriodDay(
      PeriodDay periodDay, Transaction? txn) async {
    try {
      await DatabaseHelper().updateDayToPeriodDay(periodDay, txn: txn);
    } catch (e) {
      // Log the error and rethrow a custom exception
      print('Error updating Day to PeriodDay: $e');
      throw Exception('Failed to update Day to PeriodDay');
    }
  }

  // NEW: Add updateDay method
  Future<void> updateDayEntry(Day day, String userId) async {
    try {
      await DatabaseHelper().updateDay(day, userId);
    } catch (e) {
      print('Error updating Day entry: $e');
      throw Exception('Failed to update Day entry');
    }
  }

  // NEW: Add updatePeriodDay method
  Future<void> updatePeriodDayEntry(PeriodDay periodDay, String userId) async {
    try {
      await DatabaseHelper().updatePeriodDay(periodDay, userId);
    } catch (e) {
      print('Error updating PeriodDay entry: $e');
      throw Exception('Failed to update PeriodDay entry');
    }
  }
}
