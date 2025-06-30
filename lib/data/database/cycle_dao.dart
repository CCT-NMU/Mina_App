import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/cycle.dart';
part 'cycle_dao.g.dart';

@DriftAccessor(tables: [AppCycles])
class AppCyclesDao extends DatabaseAccessor<AppDatabase>
    with _$AppCyclesDaoMixin {
  AppCyclesDao(AppDatabase db) : super(db);

  Future<int> insertCycle(AppCyclesCompanion cycle) {
    return into(appCycles).insert(cycle);
  }

  Future<bool> updateCycle(AppCycle cycle) {
    return update(appCycles).replace(cycle);
  }

  Future<int> deleteCycle(int id, String userId) {
    return (delete(appCycles)
          ..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId)))
        .go();
  }

  Future<List<AppCycle>> getAllCycles(String userId) async {
    final query = select(appCycles)..where((tbl) => tbl.userId.equals(userId));
    return query.get().then((rows) => rows.cast<AppCycle>());
  }

  Future<AppCycle?> getCycleByStartDate(
      DateTime startDate, String userId) async {
    final query = select(appCycles)
      ..where(
          (tbl) => tbl.startDate.equals(startDate) & tbl.userId.equals(userId));
    return query.getSingleOrNull();
  }
}
