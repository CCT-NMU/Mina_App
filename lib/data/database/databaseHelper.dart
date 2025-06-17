import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:mina_app/common/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:mina_app/data/model/model.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class DatabaseHelper {
  //Create Singleton instance of the database
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final io.Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = p.join(appDocDir.path, 'mina_database.db');

    return await openDatabase(
      path,
      version: 5, // Increment version to trigger onUpgrade
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 5) {
      // Add Cycle table if upgrading from version < 4
      await db.execute('''CREATE TABLE IF NOT EXISTS Cycle (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          startDate STRING, 
          periodEndDate STRING, 
          endDate STRING,
          userId STRING
          )
          ''');

      // Add userId column to existing tables
      await db.execute('ALTER TABLE Day ADD COLUMN userId STRING');
      await db.execute('ALTER TABLE PeriodDay ADD COLUMN userId STRING');
      await db.execute('ALTER TABLE UserSettings ADD COLUMN userId STRING');
    }
  }

  /// This is the callback function that is called when the database is first
  /// created. It creates the following tables:
  ///
  /// - UserSettings: a table to store user settings such as the selected theme
  /// - Day: a table to store Day objects, which contain information about a
  ///   given day in the user's cycle
  /// - PeriodDay: a table to store PeriodDay objects, which contain information
  ///   about the user's period
  /// - Mood: a table to store Mood objects, which contain information about the
  ///   user's mood
  /// - Symptom: a table to store Symptom objects, which contain information
  ///   about the user's symptoms

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE UserSettings(
      Key STRING,
      Value STRING,
      userId STRING,
      PRIMARY KEY (Key, userId)
      )
    ''');

    await db.execute('''CREATE TABLE Day(
    Date STRING,
    IsPeriodDay INTEGER,
    Note STRING,
    symptomList STRING,
    moodlist STRING,
    userId STRING,
    PRIMARY KEY (Date, userId)
    )
    ''');

    await db.execute('''
  CREATE TABLE PeriodDay(
    Date STRING,
    FlowWeight INTEGER,
    IsPeriodStartDay INTEGER,
    IsPeriodEndDay INTEGER,
    userId STRING,
    PRIMARY KEY (Date, userId),
    FOREIGN KEY (Date, userId) REFERENCES Day(Date, userId)
  )
''');

    await db.execute('''
  CREATE TABLE Cycle (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    startDate STRING,
    periodEndDate STRING,
    endDate STRING,
    userId STRING
  )
''');

    await db.execute('''CREATE TABLE Mood (
    MoodId INTEGER PRIMARY KEY AUTOINCREMENT,
    Name STRING
    
    )''');

    await db.execute('''CREATE TABLE Symptom (
    SymptomId INTEGER PRIMARY KEY AUTOINCREMENT,
    Name STRING
   
    )''');
  }

//##CRUD operations for UserSettings

  /// Inserts or updates a user setting for a specific user.
  ///
  /// If a setting with the given [key] and [userId] does not exist, it is inserted.
  /// Otherwise, the existing setting is updated with the new [value].
  ///
  /// This method is asynchronous because it may need to wait for the database
  /// to initialize.
  Future<void> insertOrUpdateUserSetting(
      String key, String value, String userId) async {
    final db = await database;
    await db.insert(
      'UserSettings',
      {'Key': key, 'Value': value, 'userId': userId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieves a setting from the database for a specific user.
  ///
  /// The [key] parameter is the name of the setting to retrieve.
  /// The [userId] parameter identifies which user's setting to retrieve.
  ///
  /// Returns the value of the setting if it exists, or `null` if it does not.
  ///
  /// This method is asynchronous because it may need to wait for the database
  /// to initialize.

  Future<String?> getUserSetting(String key, String userId) async {
    final db = await database;

    // Query the setting
    final List<Map<String, dynamic>> result = await db.query(
      'UserSettings',
      where: 'Key = ? AND userId = ?',
      whereArgs: [key, userId],
    );

    if (result.isNotEmpty) {
      return result.first['Value'] as String;
    } else {
      return null; // Return null if the key does not exist
    }
  }

  /// Retrieves all settings from the database as a map for a specific user.
  ///
  /// The returned map will have the setting names as keys and the
  /// corresponding setting values as values.
  ///
  /// This method is asynchronous because it may need to wait for the database
  /// to initialize.
  Future<Map<String, String>> getAllSettings(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> settings = await db.query(
      'UserSettings',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return Map.fromEntries(
      settings
          .map((row) => MapEntry(row['Key'] as String, row['Value'] as String)),
    );
  }

//CRUD operations for Day table
  //CREATE DAY Record
  /// Inserts a day entry into the database for a specific user.
  ///
  /// If a day entry with the same date and userId already exists, it will be replaced.
  /// The [day] parameter contains the details of the day entry to be inserted.
  /// The [userId] parameter identifies which user this entry belongs to.
  /// This operation uses [ConflictAlgorithm.replace] to handle conflicts.

  Future<void> insertDay(Day day, String userId) async {
    final db = await database;
    try {
      db.transaction((txn) async {
        var dayMap = day.toMap();
        dayMap['userId'] = userId;
        await txn.insert(
          'Day',
          dayMap,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
    } on Exception catch (e) {
      // Log the error and rethrow a custom exception
      print('Error inserting Day entry: $e');
      throw Exception('Failed to insert Day entry');
    }
  }

  //READ DAY Record
  /// Retrieves a day entry from the database for a specific user.
  ///
  /// If a day entry with the given [date] and [userId] does not exist, returns `null`.
  /// Otherwise, returns the Day object or a Period Day object
  Future<Day?> getDay(DateTime date, String userId, {Transaction? txn}) async {
    final db = await database;
    final executor = txn ?? db;
    final List<Map<String, dynamic>> result = await executor.rawQuery('''
      SELECT Day.Date,Day.IsPeriodDay,Day.Note,Day.symptomList,Day.moodList,,Day.userId,
      PeriodDay.FlowWeight,PeriodDay.IsPeriodStartDay,PeriodDay.IsPeriodEndDay
      FROM Day
      LEFT JOIN PeriodDay ON Day.Date = PeriodDay.Date AND Day.userId = PeriodDay.userId
      WHERE Day.Date=? AND Day.userId=?
      ''', [date.toIso8601String(), userId]);
    if (result.isNotEmpty) {
      final Map<String, dynamic> row = result.first;
      if (row['IsPeriodDay'] == 1) {
        return PeriodDay.fromMap(row);
      } else {
        return Day.fromMap(row);
      }
    } else {
      return null;
    }
  }

//UPDATE DAY Record
  Future<void> updateDay(Day day, String userId) async {
    final db = await database;

    await db.transaction((txn) async {
      var dayMap = day.toMap();
      dayMap['userId'] = userId;

      if (!day.isPeriodDay) {
        await txn.update(
          'Day',
          dayMap,
          where: 'Date = ? AND userId = ?',
          whereArgs: [day.date.toIso8601String(), userId],
        );
        // Delete Period information if day is changed from a Period Day to a non-Period Day
        await txn.delete(
          'PeriodDay',
          where: 'Date = ? AND userId = ?',
          whereArgs: [day.date.toIso8601String(), userId],
        );
      } else {
        await txn.update(
          'Day',
          dayMap,
          where: 'Date = ? AND userId = ?',
          whereArgs: [day.date.toIso8601String(), userId],
        );
      }
    });
  }

  //DELETE DAY Record
  /// Deletes a day entry and its corresponding period day entry from the database for a given date and user.
  ///
  /// This method removes the records associated with the specified [date] and [userId] from both the 'Day' and
  /// 'PeriodDay' tables. It first deletes the entry from the 'PeriodDay' table to ensure referential
  /// integrity, then deletes the entry from the 'Day' table. Returns the number of rows affected
  /// in the 'Day' table.

  Future<int> deleteDayEntry(DateTime date, String userId) async {
    final db = await database;

    return await db.transaction((txn) async {
      // Delete corresponding PeriodDay
      await txn.delete(
        'PeriodDay',
        where: 'Date = ? AND userId = ?',
        whereArgs: [date.toIso8601String(), userId],
      );

      // Delete from Day table and return the number of rows affected
      return await txn.delete(
        'Day',
        where: 'Date = ? AND userId = ?',
        whereArgs: [date.toIso8601String(), userId],
      );
    });
  }

//CRUD operations for PeriodDay
  Future<void> insertPeriodDay(PeriodDay periodDay, String userId,
      {Transaction? txn}) async {
    final db = await database;
    final executor = txn ?? db;

    var dayMap = periodDay.toMap();
    dayMap['userId'] = userId;

    var periodDayMap = periodDay.toPeriodDayMap();
    periodDayMap['userId'] = userId;

    await executor.insert(
      'Day',
      dayMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // Insert into PeriodDay table
    await executor.insert(
      'PeriodDay',
      periodDayMap, // Includes only PeriodDay-specific columns + userId
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<PeriodDay?> getPeriodDayByDate(DateTime date, String userId,
      {Transaction? txn}) async {
    final db = await database;
    final executor = txn ?? db;
    final List<Map<String, dynamic>> result = await executor.query(
      'PeriodDay',
      where: 'Date = ? AND userId = ?',
      whereArgs: [date.toIso8601String(), userId],
    );
    if (result.isNotEmpty) {
      return PeriodDay.fromMap(result.first);
    } else {
      return null;
    }
  }

//update a Day to a PeriodDay
  Future<void> updateDayToPeriodDay(PeriodDay periodDay,
      {Transaction? txn}) async {
    final db = await database;
    final executor = txn ?? db;
    final List<Map<String, dynamic>> result = await executor.query(
      'Day',
      where: 'Date = ?',
      whereArgs: [periodDay.date.toIso8601String()],
    );

    Map<String, dynamic> existing = result.isNotEmpty ? result.first : {};

    // Merge existing fields if not set in periodDay
    final updatedMap = {
      ...existing,
      ...periodDay.toMap(),
      'IsPeriodDay': 1,
      'note': periodDay.note ?? existing['note'],
      'moodList': periodDay.moodList ?? existing['moodList'],
      'symptomList': periodDay.symptomList ?? existing['symptomList'],
    };

    await executor.update(
      'Day',
      updatedMap,
      where: 'Date = ?',
      whereArgs: [periodDay.date.toIso8601String()],
    );

    await executor.insert(
      'PeriodDay',
      periodDay.toPeriodDayMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//updates existing PeriodDay entry
  Future<void> updatePeriodDay(PeriodDay periodDay, String userId,
      {Transaction? txn}) async {
    final db = await database;

    final executor = txn ?? db;
    var periodDayMap = periodDay.toPeriodDayMap();
    periodDayMap['userId'] = userId;

    await executor.update(
      'PeriodDay',
      periodDayMap,
      where: 'Date = ? AND userId = ?',
      whereArgs: [periodDay.date.toIso8601String(), userId],
    );
  }

  /// Deletes a PeriodDay entry for a given date and user from the database.
  ///
  /// This method removes the corresponding PeriodDay record from the 'PeriodDay'
  /// table based on the provided [date] and [userId]. Additionally, it updates the 'Day' table
  /// to set the 'IsPeriodDay' flag to false, indicating that the day is no longer
  /// considered a period day.
  ///

  Future<int> deletePeriodDay(DateTime date, String userId,
      {Transaction? txn}) async {
    final db = await database;
    final executor = txn ?? db;

    try {
      // Update the Day table to mark it as not a period day
      await executor.update(
        'Day',
        {'IsPeriodDay': 0}, // Set IsPeriodDay to false
        where: 'Date = ? AND userId = ?',
        whereArgs: [date.toIso8601String(), userId],
      );
      // Delete the PeriodDay entry
      return await executor.delete(
        'PeriodDay',
        where: 'Date = ? AND userId = ?',
        whereArgs: [date.toIso8601String(), userId],
      );
    } catch (e) {
      debugPrint('Error deleting PeriodDay: $e');
      return 0; // Return 0 to indicate failure
    }
  }

  Future<List<Day>> getPeriodDaysInRange(
      DateTime start, DateTime end, String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Day',
      where: 'Date BETWEEN ? AND ? AND IsPeriodDay = 1 AND userId = ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String(), userId],
    );
    return List.generate(maps.length, (i) {
      return Day.fromMap(maps[i]);
    });
  }

  Future<List<Day>> getDaysInRange(DateTime start, DateTime end) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Day',
      where: 'Date BETWEEN ? AND ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
    );
    return List.generate(maps.length, (i) {
      return Day.fromMap(maps[i]);
    });
  }

  //READ ALL DAY Records for a specific user
  Future<List<Day>> getCombinedDayAndPeriodDayRecords(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT Day.Date,Day.IsPeriodDay,Day.Note,Day.symptomList,Day.moodList,Day.userId,
      PeriodDay.FlowWeight,PeriodDay.IsPeriodStartDay,PeriodDay.IsPeriodEndDay
      FROM Day
      LEFT JOIN PeriodDay ON Day.Date = PeriodDay.Date AND Day.userId = PeriodDay.userId
      WHERE Day.userId = ?
      ORDER BY Day.Date ASC''', [userId]);
    return result.map<Day>((row) {
      if (row['IsPeriodDay'] == 1) {
        // If IsPeriodDay is 1, create a PeriodDay object
        return PeriodDay.fromMap(row);
      } else {
        // Otherwise, create a Day object
        return Day.fromMap(row);
      }
    }).toList();
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.transaction((txn) async {
      // Clear all tables
      await txn.delete('Day');
      await txn.delete('PeriodDay');
      await txn.delete('UserSettings');
      await txn.delete('Cycle');
    });
  }

  Future<void> clearUserData(String userId) async {
    final db = await database;
    await db.transaction((txn) async {
      // Clear data for specific user only
      await txn.delete('Day', where: 'userId = ?', whereArgs: [userId]);
      await txn.delete('PeriodDay', where: 'userId = ?', whereArgs: [userId]);
      await txn
          .delete('UserSettings', where: 'userId = ?', whereArgs: [userId]);
      await txn.delete('Cycle', where: 'userId = ?', whereArgs: [userId]);
    });
  }

  Future<List<Day>> getAllDays(String userId) async {
    return getCombinedDayAndPeriodDayRecords(userId);
  }

  // Cycle operations with userId
  Future<void> insertCycle(Map<String, dynamic> cycle, String userId) async {
    final db = await database;
    cycle['userId'] = userId;
    await db.insert('Cycle', cycle,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getCycles(String userId) async {
    final db = await database;
    return await db.query('Cycle', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<void> updateCycle(
      int id, Map<String, dynamic> cycle, String userId) async {
    final db = await database;
    cycle['userId'] = userId;
    await db.update('Cycle', cycle,
        where: 'id = ? AND userId = ?', whereArgs: [id, userId]);
  }

  Future<void> deleteCycle(int id, String userId) async {
    final db = await database;
    await db.delete('Cycle',
        where: 'id = ? AND userId = ?', whereArgs: [id, userId]);
  }

//Cycle operations

  /// Retrieves the latest Cycle record from the database.
  //
  /// Returns a Cycle object if a record is found, otherwise returns null.
  ///
  /// The query is sorted by the 'id' column in descending order (newest first),
  /// and limited to a single record (the latest one).
  Future<Cycle?> getPresentCycle() async {
    final db = await database;

    final result = await db.query("Cycle", orderBy: "id DESC", limit: 1);

    if (result.isNotEmpty) {
      return Cycle.fromMap(result.first);
    } else {
      return null;
    }
  }

  /// Retrieves the Cycle record from the database that contains the given [date].
  ///
  /// The query is filtered by the condition that the Cycle's 'startDate' is
  /// less than or equal to the given [date], and its 'endDate' is either null
  /// or greater than or equal to the given [date].
  ///
  /// Returns a Cycle object if a record is found, otherwise returns null.
  Future<Cycle?> getCycle(DateTime date) async {
    final db = await database;
    print(
        "getting Cycle with ${Utils().normalizedDate(date).toIso8601String()}");
    final result = await db.query(
      "Cycle",
      where:
          'date(?) >= date(startDate) AND (date(endDate) IS NULL OR date(?) <= date(endDate))',
      whereArgs: [
        Utils().normalizedDate(date).toIso8601String(),
        Utils().normalizedDate(date).toIso8601String()
      ],
    );
    if (result.isNotEmpty) {
      return Cycle.fromMap(result.first);
    } else {
      return null;
    }
  }
}
