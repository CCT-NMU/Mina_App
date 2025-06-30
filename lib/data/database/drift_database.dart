import 'package:drift/drift.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mina_app/data/database/cycle_dao.dart';
import 'package:mina_app/data/database/days_dao.dart';
import 'package:mina_app/data/database/mood_dao.dart';
import 'package:mina_app/data/database/period_day_dao.dart';
import 'package:mina_app/data/database/symptom_doa.dart';
import 'package:mina_app/data/database/user_settings_dao.dart';
import 'package:mina_app/data/database/users_dao.dart';
import 'notes_dao.dart';

part 'drift_database.g.dart';

class AppUsers extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get surname => text().nullable()();
  TextColumn get email => text().nullable()();
  DateTimeColumn get birthday => dateTime().nullable()();
  IntColumn get avgCycleLength => integer().nullable()();
  IntColumn get avgPeriodLength => integer().nullable()();
  DateTimeColumn get lastestCycleStart => dateTime().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class AppUserSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {key, userId};
}

class AppDays extends Table {
  DateTimeColumn get date => dateTime()();
  BoolColumn get isPeriodDay => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
  TextColumn get symptomList => text().nullable()();
  TextColumn get moodList => text().nullable()();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {date, userId};
}

class AppPeriodDays extends Table {
  DateTimeColumn get date => dateTime()();
  IntColumn get flowWeight => integer().nullable()();
  BoolColumn get isPeriodStartDay =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isPeriodEndDay =>
      boolean().withDefault(const Constant(false))();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {date, userId};
}

class AppCycles extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get periodEndDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get userId => text()();
}

class AppMoods extends Table {
  DateTimeColumn get date => dateTime()();
  TextColumn get name => text()();
}

class AppSymptoms extends Table {
  DateTimeColumn get date => dateTime()();
  TextColumn get name => text()();
}

class AppNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

//,DaysDao,PeriodDaysDao,CyclesDao,MoodsDao,SymptomsDao
@DriftDatabase(tables: [
  AppUserSettings,
  AppDays,
  AppPeriodDays,
  AppMoods,
  AppSymptoms,
  AppUsers,
  AppNotes,
  AppCycles,
], daos: [
  AppUserSettingsDao,
  AppDaysDao,
  AppPeriodDaysDao,
  AppMoodsDao,
  AppSymptomsDao,
  AppUsersDao,
  AppNotesDao,
  AppCyclesDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
