import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
part 'period_day_dao.g.dart';

@DriftAccessor(tables: [PeriodDays])
class PeriodDaysDao extends DatabaseAccessor<AppDatabase>
    with _$PeriodDaysDaoMixin {
  PeriodDaysDao(AppDatabase db) : super(db);

  Future<int> insertPeriodDay(PeriodDaysCompanion periodDay) =>
      into(periodDays).insert(periodDay);

  Future<PeriodDay?> getPeriodDay(String date, String userId) =>
      (select(periodDays)
            ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
          .getSingleOrNull();

  Future<bool> updatePeriodDay(PeriodDay periodDay) =>
      update(periodDays).replace(periodDay);

  Future<int> deletePeriodDay(String date, String userId) => (delete(periodDays)
        ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
      .go();
}
