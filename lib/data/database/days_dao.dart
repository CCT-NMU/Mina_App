import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/model/symptom_list.dart';
import 'package:mina_app/services/auth_service/platform/supabase_auth_service.dart%20';
import 'package:sqflite_common/sqlite_api.dart';
part 'days_dao.g.dart';

@DriftAccessor(tables: [AppDays])
class AppDaysDao extends DatabaseAccessor<AppDatabase> with _$AppDaysDaoMixin {
  AppDaysDao(AppDatabase db) : super(db);

  Future<int> insertDay(Day day, String userId) =>
      into(appDays).insert(toDriftDay(day, userId));

  Future<Day?> getDay(DateTime date, String userId) async {
    final row = await (select(appDays)
          ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
        .getSingleOrNull();
    return row != null ? fromDriftDay(row) : null;
  }

  Future<List<Day>> getAllDays(String userId) async {
    final rows = await (select(appDays)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
    return rows.map(fromDriftDay).toList();
  }

  Future<bool> updateDay(Day day, String userId) {
    final companion = toDriftDay(day, userId);
    return update(appDays).replace(companion);
  }

  Future<int> deleteDay(DateTime date, String userId) => (delete(appDays)
        ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
      .go();

  insertPeriodDay(PeriodDay periodDay, String userId, {Transaction? txn}) {}

  getPeriodDaysInRange(DateTime startDate, DateTime endDate, String userId) {
    return (select(appDays)
          ..where((tbl) =>
              tbl.date.isBetweenValues(startDate, endDate) &
              tbl.userId.equals(userId)))
        .get()
        .then((rows) => rows.map(fromDriftDay).toList());
  }

  deletePeriodDay(DateTime date, String userId) {
    return (delete(appDays)
          ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
        .go();
  }

  getDaysInRange(DateTime firstDayOfPrevMonth, DateTime lastDayOfNextMonth) {
    return (select(appDays)
          ..where((tbl) => tbl.date
              .isBetweenValues(firstDayOfPrevMonth, lastDayOfNextMonth)))
        .get()
        .then((rows) => rows.map(fromDriftDay).toList());
  }

  updateDayToPeriodDay(PeriodDay periodDay, {Transaction? txn}) {
    final userId = SupabaseAuthService().currentUser!.id;
    final companion = AppDaysCompanion(
      date: Value(periodDay.date),
      isPeriodDay: Value(true),
      note: Value(periodDay.note),
      symptomList: Value(periodDay.symptomList?.toString()),
      moodList: Value(periodDay.moodList?.toString()),
      userId: Value(userId),
    );
    return update(appDays).replace(companion);
  }
}

Day fromDriftDay(AppDay row) {
  return Day(
      date: row.date,
      isPeriodDay: row.isPeriodDay,
      note: row.note,
      symptomList: SymptomList.fromString(row.symptomList ?? ""),
      moodList: MoodList.fromString(row.moodList ?? ""));
}

AppDaysCompanion toDriftDay(Day day, String userId) {
  return AppDaysCompanion(
    date: Value(day.date),
    isPeriodDay: Value(day.isPeriodDay),
    note: Value(day.note),
    symptomList: Value(day.symptomList?.toString()),
    moodList: Value(day.moodList?.toString()),
    userId: Value(userId),
  );
}
