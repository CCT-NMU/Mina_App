import 'package:flutter/material.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/model/model.dart';
import 'package:sqflite/sqflite.dart';

class DayEntryRepository {
  DayEntryRepository._privateConstructor();
  static final DayEntryRepository _instance =
      DayEntryRepository._privateConstructor();
  static DayEntryRepository get instance => _instance;

  Future<void> insertDayEntry(Day day) async {
    try {
      await DatabaseHelper().insertDay(day);
    } catch (e) {
      // Log the error and rethrow a custom exception
      print('Error inserting Day entry: $e');
      throw Exception('Failed to insert Day entry');
    }
  }

  Future<void> insertPeriodDayEntry(
      PeriodDay periodDay, Transaction? txn) async {
    try {
      await DatabaseHelper().insertPeriodDay(periodDay,
          txn: txn); //method handles the insertion in
      //both Day table and PeriodDay table.
    } catch (e) {
      // Log the error and rethrow a custom exception
      print('Error inserting PeriodDay entry: $e');
      throw Exception('Failed to insert PeriodDay entry');
    }
  }

  getPeriodDaysInRange(DateTime startDate, DateTime endDate) async {
    try {
      return await DatabaseHelper().getPeriodDaysInRange(startDate, endDate);
    } catch (e) {
      // Log the error and rethrow a custom exception
      print('Error retrieving PeriodDays in range: $e');
      throw Exception('Failed to retrieve PeriodDays in range');
    }
  }

  Future<Day?> getDayEntry(DateTime date) async {
    try {
      var day = await DatabaseHelper().getDay(date);
      return day;
    } catch (e) {
      // Log the error and rethrow a custom exception
      print('Error retrieving Day entry: $e');
      throw Exception('Failed to retrieve Day entry');
    }
  }

  Future<List<Day>> getAllDaysandPeriodDays() async {
    try {
      final result = await DatabaseHelper().getCombinedDayAndPeriodDayRecords();
      return result;
    } catch (e) {
      // Log the error and rethrow a custom exception
      print('Error retrieving all Days and PeriodDays: $e');
      throw Exception('Failed to retrieve all Days and PeriodDays');
    }
  }

  Future<int> deleteDayEntry(DateTime date) async {
    try {
      return await DatabaseHelper().deleteDayEntry(date);
    } catch (e) {
      // Log the error and rethrow a custom exception
      print('Error deleting Day entry: $e');
      throw Exception('Failed to delete Day entry');
    }
  }

  Future<int> deletePeriodDayEntry(DateTime date) async {
    try {
      return await DatabaseHelper().deletePeriodDay(date);
    } catch (e) {
      // Log the error and rethrow a custom exception
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
}
