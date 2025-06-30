import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/cycle.dart';
part 'cycle_dao.g.dart';

@DriftAccessor(tables: [AppCycles])
class AppCyclesDao extends DatabaseAccessor<AppDatabase>
    with _$AppCyclesDaoMixin {
  AppCyclesDao(AppDatabase db) : super(db);

  Future<int> insertCycle(Cycle cycle, String userId) async {
    final companion = AppCyclesCompanion.insert(
      userId: userId,
      startDate: cycle.startDate!,
      endDate: Value(cycle.endDate),
      periodEndDate: Value(cycle.periodEndDate!),
    );
    return into(appCycles).insert(companion);
  }

  Future<bool> updateCycle(int id, Cycle cycle, String userId) async {
    AppCyclesCompanion companion = AppCyclesCompanion(
      id: Value(id),
      userId: Value(userId),
      startDate: Value(cycle.startDate!),
      endDate: Value(cycle.endDate),
      periodEndDate: Value(cycle.periodEndDate!),
    );
    final result = await (update(appCycles)
          ..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId)))
        .replace(companion);
    return result;
  }

  Future<int> deleteCycle(int id, String userId) {
    return (delete(appCycles)
          ..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId)))
        .go();
  }

  Future<List<Cycle>> getAllCycles(String userId) async {
    final query = select(appCycles)..where((tbl) => tbl.userId.equals(userId));
    final rows = await query.get();
    return rows
        .map((row) => Cycle(
              userId: row.userId,
              startDate: row.startDate,
              endDate: row.endDate,
              periodEndDate: row.periodEndDate,
            ))
        .toList();
  }

  Future<Cycle?> getCycleByStartDate(DateTime startDate, String userId) async {
    final query = select(appCycles)
      ..where(
          (tbl) => tbl.startDate.equals(startDate) & tbl.userId.equals(userId));
    final result = await query.getSingleOrNull();
    if (result == null) {
      return null;
    }
    return appCycleToCycle(result);
  }

  Future<Cycle?> getPresentCycle(String userId) async {
    final query = select(appCycles)
      ..where((tbl) => tbl.userId.equals(userId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.startDate)])
      ..limit(1);
    final result = await query.getSingleOrNull();
    if (result == null) {
      return null;
    }
    return appCycleToCycle(result);
  }

  Future<Cycle?> appCycleToCycle(AppCycle result) async {
    return Cycle(
      userId: result.userId,
      startDate: result.startDate,
      endDate: result.endDate,
      periodEndDate: result.periodEndDate,
    );
  }

  getCycleByDate(DateTime normalizedDate, String userId) {
    final query = select(appCycles)
      ..where((tbl) =>
          tbl.startDate.isSmallerOrEqualValue(normalizedDate) &
          tbl.endDate.isBiggerOrEqualValue(normalizedDate) &
          tbl.userId.equals(userId));
    return query.getSingleOrNull().then((result) {
      if (result == null) {
        return null;
      }
      return appCycleToCycle(result);
    });
  }
}
