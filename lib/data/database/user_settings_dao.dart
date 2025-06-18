import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/user.dart';

part 'user_settings_dao.g.dart';

@DriftAccessor(tables: [UserSettingsTable])
class UserSettingsTableDao extends DatabaseAccessor<AppDatabase>
    with _$UserSettingsTableDaoMixin {
  UserSettingsTableDao(AppDatabase db) : super(db);
  Future<void> insertOrUpdateUserSetting(
      String key, String value, String userId) async {
    into(userSettingsTable).insertOnConflictUpdate(
      UserSettingsTableCompanion(
        key: Value(key),
        value: Value(value),
        userId: Value(userId),
      ),
    );
  }

  Future<String?> getUserSetting(String key, String userId) async {
    final result = await (select(userSettingsTable)
          ..where((tbl) => tbl.key.equals(key) & tbl.userId.equals(userId)))
        .getSingleOrNull();
    return result?.value;
  }

  Future<Map<String, String>> getAllSettings(String userId) async {
    final settings = await (select(userSettingsTable)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
    return {for (var s in settings) s.key: s.value};
  }

  // Load a User from the UserSettings table
  Future<User> getUser(String userId) async {
    final settings = await (select(userSettingsTable)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
    final map = {for (var s in settings) s.key: s.value};
    return User(
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      birthday: map['birthday'],
      avgCycleLength: int.tryParse(map['avgCycleLength'] ?? '0') ?? 0,
      avgPeriodLength: int.tryParse(map['avgPeriodLength'] ?? '0') ?? 0,
      lastestCycleStart: map['lastestCycleStart'] != null
          ? DateTime.tryParse(map['lastestCycleStart']!) ??
              DateTime(2025, 04, 07)
          : DateTime(2025, 04, 07),
    );
  }

  // Save a User to the UserSettings table
  Future<void> saveUser(User user, String userId) async {
    final settings = [
      UserSettingsTableCompanion(
        key: Value('name'),
        value: Value(user.name ?? ''),
        userId: Value(userId),
      ),
      UserSettingsTableCompanion(
        key: Value('surname'),
        value: Value(user.surname ?? ''),
        userId: Value(userId),
      ),
      UserSettingsTableCompanion(
        key: Value('email'),
        value: Value(user.email ?? ''),
        userId: Value(userId),
      ),
      UserSettingsTableCompanion(
        key: Value('birthday'),
        value: Value(user.birthday ?? ''),
        userId: Value(userId),
      ),
      UserSettingsTableCompanion(
        key: Value('avgCycleLength'),
        value: Value(user.avgCycleLength.toString()),
        userId: Value(userId),
      ),
      UserSettingsTableCompanion(
        key: Value('avgPeriodLength'),
        value: Value(user.avgPeriodLength.toString()),
        userId: Value(userId),
      ),
      UserSettingsTableCompanion(
        key: Value('lastestCycleStart'),
        value: Value(user.lastestCycleStart.toIso8601String()),
        userId: Value(userId),
      ),
    ];
    for (final setting in settings) {
      await into(userSettingsTable).insertOnConflictUpdate(setting);
    }
  }
}
