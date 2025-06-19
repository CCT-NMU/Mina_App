import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/day.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/data/model/symptom_list.dart';
part 'days_dao.g.dart';

@DriftAccessor(tables: [AppDays])
class AppDaysDao extends DatabaseAccessor<AppDatabase> with _$AppDaysDaoMixin {
  AppDaysDao(AppDatabase db) : super(db);

  Future<int> insertDay(Day day, String userId) =>
      into(appDays).insert(toDriftDay(day, userId));

  Future<Day?> getDay(String date, String userId) async {
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

  Future<int> deleteDay(String date, String userId) => (delete(appDays)
        ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
      .go();
}

Day fromDriftDay(AppDay row) {
  return Day(
      date: DateTime.parse(row.date),
      isPeriodDay: row.isPeriodDay,
      note: row.note,
      symptomList: SymptomList.fromString(row.symptomList ?? ""),
      moodList: MoodList.fromString(row.moodList ?? ""));
}

AppDaysCompanion toDriftDay(Day day, String userId) {
  return AppDaysCompanion(
    date: Value(day.date.toIso8601String()),
    isPeriodDay: Value(day.isPeriodDay),
    note: Value(day.note),
    symptomList: Value(day.symptomList?.toString()),
    moodList: Value(day.moodList?.toString()),
    userId: Value(userId),
  );
}
