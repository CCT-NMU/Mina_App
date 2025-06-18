import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
part 'cycle_dao.g.dart';

@DriftAccessor(tables: [Cycles])
class CyclesDao extends DatabaseAccessor<AppDatabase> with _$CyclesDaoMixin {
  CyclesDao(AppDatabase db) : super(db);

  Future<int> insertCycle(CyclesCompanion cycle) => into(cycles).insert(cycle);

  Future<List<Cycle>> getCycles(String userId) =>
      (select(cycles)..where((tbl) => tbl.userId.equals(userId))).get();

  Future<bool> updateCycle(Cycle cycle) => update(cycles).replace(cycle);

  Future<int> deleteCycle(int id, String userId) => (delete(cycles)
        ..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId)))
      .go();
}
