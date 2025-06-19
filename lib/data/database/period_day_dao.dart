import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/model/symptom_list.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'days_dao.dart';
part 'period_day_dao.g.dart';

@DriftAccessor(tables: [AppPeriodDays, AppDays])
class AppPeriodDaysDao extends DatabaseAccessor<AppDatabase>
    with _$AppPeriodDaysDaoMixin {
  AppPeriodDaysDao(AppDatabase db) : super(db);

  Future<int> insertPeriodDay(AppPeriodDaysCompanion periodDay) =>
      into(appPeriodDays).insert(periodDay);

  Future<AppPeriodDay?> getPeriodDay(String date, String userId) async {
    final row = await (select(appPeriodDays)
          ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
        .getSingleOrNull();
    return row == null ? null : row;
  }

  Future<bool> updatePeriodDay(AppPeriodDay periodDay) =>
      update(appPeriodDays).replace(periodDay);

  Future<int> deletePeriodDay(String date, String userId) async {
    return await transaction(() async {
      // Set isPeriodDay to false in AppDays
      final appDays = AppDaysDao(attachedDatabase).appDays;
      await (update(appDays)
            ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
          .write(const AppDaysCompanion(isPeriodDay: Value(false)));

      // Delete from AppPeriodDays
      return await (delete(appPeriodDays)
            ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
          .go();
    });
  }

  Future<PeriodDay?> getFullPeriodDay(String date, String userId) async {
    // Fetch the period day row
    final periodDay = await (select(appPeriodDays)
          ..where((tbl) => tbl.date.equals(date) & tbl.userId.equals(userId)))
        .getSingleOrNull();

    if (periodDay == null) return null;

    // Fetch the related day row for note, symptomList, moodList
    final appDaysDao = AppDaysDao(attachedDatabase);

    final day = await appDaysDao.getDay(date, userId);

    return PeriodDay(
      date: DateTime.parse(periodDay.date),
      flowWeight: FlowWeight.values[periodDay.flowWeight ?? 0],
      isPeriodStartDay: periodDay.isPeriodStartDay,
      isPeriodEndDay: periodDay.isPeriodEndDay,
      note: day?.note,
      symptomList: SymptomList.fromString(day?.symptomList as String? ?? " "),
      moodList: day != null
          ? MoodList.fromString(day.moodList as String? ?? "")
          : MoodList.fromString(""),
    );
  }

  /// Inserts both AppDay and AppPeriodDay for a PeriodDay model in a transaction
  Future<void> insertFullPeriodDay(PeriodDay periodDay, String userId) async {
    await transaction(() async {
      // Insert into AppDays
      final dayCompanion = AppDaysCompanion(
        date: Value(periodDay.date.toIso8601String()),
        isPeriodDay: const Value(true),
        note: Value(periodDay.note),
        symptomList: Value(periodDay.symptomList?.toString()),
        moodList: Value(periodDay.moodList?.toString()),
        userId: Value(userId),
      );
      await into(AppDaysDao(attachedDatabase).appDays)
          .insertOnConflictUpdate(dayCompanion);

      // Insert into AppPeriodDays
      final periodDayCompanion = AppPeriodDaysCompanion(
        date: Value(periodDay.date.toIso8601String()),
        flowWeight: Value(periodDay.flowWeight.index),
        isPeriodStartDay: Value(periodDay.isPeriodStartDay),
        isPeriodEndDay: Value(periodDay.isPeriodEndDay),
        userId: Value(userId),
      );
      await into(appPeriodDays).insertOnConflictUpdate(periodDayCompanion);
    });
  }
}
