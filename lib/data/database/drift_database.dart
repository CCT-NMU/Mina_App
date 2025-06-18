import 'package:drift/drift.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mina_app/data/database/cycle_dao.dart';
import 'package:mina_app/data/database/days_dao.dart';
import 'package:mina_app/data/database/mood_dao.dart';
import 'package:mina_app/data/database/period_day_dao.dart';
import 'package:mina_app/data/database/symptom_doa.dart';
import 'package:mina_app/data/database/user_settings_dao.dart';
import 'notes_dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'drift_database.g.dart';

class UserSettingsTable extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {key, userId};
}

class Days extends Table {
  TextColumn get date => text()();
  BoolColumn get isPeriodDay => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
  TextColumn get symptomList => text().nullable()();
  TextColumn get moodList => text().nullable()();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {date, userId};
}

class PeriodDays extends Table {
  TextColumn get date => text()();
  IntColumn get flowWeight => integer().nullable()();
  BoolColumn get isPeriodStartDay =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isPeriodEndDay =>
      boolean().withDefault(const Constant(false))();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {date, userId};
}

class Cycles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get startDate => text()();
  TextColumn get periodEndDate => text().nullable()();
  TextColumn get endDate => text().nullable()();
  TextColumn get userId => text()();
}

class Moods extends Table {
  TextColumn get date => text()();
  TextColumn get name => text()();
}

class Symptoms extends Table {
  TextColumn get date => text()();
  TextColumn get name => text()();
}

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
}

//,DaysDao,PeriodDaysDao,CyclesDao,MoodsDao,SymptomsDao
@DriftDatabase(tables: [
  UserSettingsTable,
  Days,
  PeriodDays,
  Cycles,
  Moods,
  Symptoms,
  Notes
], daos: [
  UserSettingsTableDao,
  DaysDao,
  PeriodDaysDao,
  CyclesDao,
  MoodsDao,
  SymptomsDao,
  NotesDao
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
