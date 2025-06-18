import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
part 'days_dao.g.dart';

@DriftAccessor(tables: [Days])
class DaysDao extends DatabaseAccessor<AppDatabase> with _$DaysDaoMixin {
  DaysDao(AppDatabase db) : super(db);

  Future<int> insertDay(DaysCompanion day) => into(days).insert(day);

  Future<Day?> getDay(String date, String userId) => (select(days)
        ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
      .getSingleOrNull();

  Future<List<Day>> getAllDays(String userId) =>
      (select(days)..where((tbl) => tbl.userId.equals(userId))).get();

  Future<bool> updateDay(Day day) => update(days).replace(day);

  Future<int> deleteDay(String date, String userId) => (delete(days)
        ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
      .go();
}
