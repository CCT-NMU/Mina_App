import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/user.dart';

part 'user_settings_dao.g.dart';

@DriftAccessor(tables: [AppUserSettings])
class AppUserSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$AppUserSettingsDaoMixin {
  AppUserSettingsDao(AppDatabase db) : super(db);
  Future<void> insertOrUpdateUserSetting(
      String key, String value, String userId) async {
    into(appUserSettings).insertOnConflictUpdate(
      AppUserSettingsCompanion(
        key: Value(key),
        value: Value(value),
        userId: Value(userId),
      ),
    );
  }

  Future<String?> getUserSetting(String key, String userId) async {
    final result = await (select(appUserSettings)
          ..where((tbl) => tbl.key.equals(key) & tbl.userId.equals(userId)))
        .getSingleOrNull();
    return result?.value;
  }

  Future<Map<String, String>> getAllSettings(String userId) async {
    final settings = await (select(appUserSettings)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
    return {for (var s in settings) s.key: s.value};
  }

  // Load a User from the UserSettings table
  Future<User> getUser(String userId) async {
    final settings = await (select(appUserSettings)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
    final map = {for (var s in settings) s.key: s.value};
    return User(
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      email: map['email'] ?? '',
      birthday: map['birthday'] ?? '',
      avgCycleLength: int.tryParse(map['avgCycleLength'] ?? '0') ?? 0,
      avgPeriodLength: int.tryParse(map['avgPeriodLength'] ?? '0') ?? 0,
      lastestCycleStart: map['lastestCycleStart'] != null
          ? DateTime.tryParse(map['lastestCycleStart']!) ?? null
          : null,
    );
  }

  // Save a User to the UserSettings table
  Future<void> saveUser(User user, String userId) async {
    final settings = [
      AppUserSettingsCompanion(
        key: Value('name'),
        value: Value(user.name ?? ''),
        userId: Value(userId),
      ),
      AppUserSettingsCompanion(
        key: Value('surname'),
        value: Value(user.surname ?? ''),
        userId: Value(userId),
      ),
      AppUserSettingsCompanion(
        key: Value('email'),
        value: Value(user.email ?? ''),
        userId: Value(userId),
      ),
      AppUserSettingsCompanion(
        key: Value('birthday'),
        value: Value(user.birthday ?? ''),
        userId: Value(userId),
      ),
      AppUserSettingsCompanion(
        key: Value('avgCycleLength'),
        value: user.avgCycleLength != null
            ? Value(user.avgCycleLength.toString())
            : Value('0'),
        userId: Value(userId),
      ),
      AppUserSettingsCompanion(
        key: Value('avgPeriodLength'),
        value: user.avgPeriodLength != null
            ? Value(user.avgPeriodLength.toString())
            : Value('0'),
        userId: Value(userId),
      ),
      AppUserSettingsCompanion(
        key: Value('lastestCycleStart'),
        value: user.lastestCycleStart != null
            ? Value(user.lastestCycleStart!.toIso8601String())
            : Value('0'),
        userId: Value(userId),
      ),
    ];
    for (final setting in settings) {
      await into(appUserSettings).insertOnConflictUpdate(setting);
    }
  }
}
