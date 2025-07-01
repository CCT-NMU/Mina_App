import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mina_app/data/database/connection/shared.dart';
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:mina_app/data/database/days_dao.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/model.dart';
import 'package:sqflite/sqflite.dart';

class DayEntryRepository {
  final AppDatabase db;
  late final AppDaysDao _daysDao;

  DayEntryRepository(this.db) {
    _daysDao = db.appDaysDao;
  }
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
      await _daysDao.insertPeriodDay(periodDay, userId, txn: txn);
    } catch (e) {
      print('Error inserting PeriodDay entry: $e');
      throw Exception('Failed to insert PeriodDay entry');
    }
  }

  getPeriodDaysInRange(
      DateTime startDate, DateTime endDate, String userId) async {
    try {
      return await _daysDao.getPeriodDaysInRange(startDate, endDate, userId);
    } catch (e) {
      print('Error retrieving PeriodDays in range: $e');
      throw Exception('Failed to retrieve PeriodDays in range');
    }
  }

  Future<Day?> getDayEntry(DateTime date, String userId) async {
    try {
      var day = await _daysDao.getDay(date, userId);
      return day;
    } catch (e) {
      print('Error retrieving Day entry: $e');
      throw Exception('Failed to retrieve Day entry');
    }
  }

  Future<List<Day>> getAllDaysandPeriodDays(String userId) async {
    try {
      final result = await db.getCombinedDayAndPeriodDayRecords(userId);
      return result;
    } catch (e) {
      print('Error retrieving all Days and PeriodDays: $e');
      throw Exception('Failed to retrieve all Days and PeriodDays');
    }
  }

  Future<int> deleteDayEntry(DateTime date, String userId) async {
    try {
      return await _daysDao.deleteDay(date, userId);
    } catch (e) {
      print('Error deleting Day entry: $e');
      throw Exception('Failed to delete Day entry');
    }
  }

  Future<int> deletePeriodDayEntry(DateTime date, String userId) async {
    try {
      return await _daysDao.deletePeriodDay(date, userId);
    } catch (e) {
      debugPrint('Error deleting PeriodDay entry: $e');
      throw Exception('Failed to delete PeriodDay entry');
    }
  }

  Future<List<Day>> getDaysInRange(
      DateTime firstDayOfPrevMonth, DateTime lastDayOfNextMonth) async {
    try {
      return await _daysDao.getDaysInRange(
          firstDayOfPrevMonth, lastDayOfNextMonth);
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
      await _daysDao.updateDayToPeriodDay(periodDay, txn: txn);
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
