import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/cycle.dart';
part 'cycle_dao.g.dart';

@DriftAccessor(tables: [AppCycles])
class AppCyclesDao extends DatabaseAccessor<AppDatabase>
    with _$AppCyclesDaoMixin {
  AppCyclesDao(AppDatabase db) : super(db);

  Future<int> insertCycle(Cycle cycle, String userId) {
    final companion = toDriftCycle(cycle, userId);
    return into(appCycles).insert(companion);
  }

  Future<List<Cycle>> getCycles(String userId) async {
    final rows = await (select(appCycles)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
    return rows.map(fromDriftCycle).toList();
  }

  Future<bool> updateCycle(Cycle cycle) async {
    final cycleCompanion = toDriftCycle(cycle, cycle.userId!);
    return update(appCycles).replace(cycleCompanion);
  }

  Future<int> deleteCycle(int id, String userId) => (delete(appCycles)
        ..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId)))
      .go();

  /// Convert from Drift AppCycle to model Cycle
  Cycle fromDriftCycle(AppCycle row) {
    return Cycle(
      userId: row.userId,
      startDate: DateTime.tryParse(row.startDate),
      endDate: row.endDate != null && row.endDate!.isNotEmpty
          ? DateTime.tryParse(row.endDate!)
          : null,
      periodEndDate: row.periodEndDate != null && row.periodEndDate!.isNotEmpty
          ? DateTime.tryParse(row.periodEndDate!)
          : null,
    );
  }

  /// Convert from model Cycle to Drift AppCyclesCompanion
  AppCyclesCompanion toDriftCycle(Cycle cycle, String userId) {
    return AppCyclesCompanion(
      startDate: Value(cycle.startDate!.toIso8601String()),
      endDate: cycle.endDate != null
          ? Value(cycle.endDate!.toIso8601String())
          : const Value.absent(),
      periodEndDate: cycle.periodEndDate != null
          ? Value(cycle.periodEndDate!.toIso8601String())
          : const Value.absent(),
      userId: Value(userId),
    );
  }
}
