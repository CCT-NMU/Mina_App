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
}
