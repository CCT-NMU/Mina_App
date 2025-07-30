import 'package:flutter/foundation.dart';
import 'package:mina_app/data/database/connection/shared.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/database/user_settings_dao.dart';
import 'package:mina_app/data/database/users_dao.dart';
import 'package:mina_app/data/model/user.dart' as User;
import 'package:mina_app/data/database/databaseHelper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  late final AppDatabase database;
  late final AppUsersDao appUsersDao;
  late final AppUserSettingsDao appUserSettingsDao;

  UserRepository(this.database) {
    appUsersDao = AppUsersDao(database);
    appUserSettingsDao = AppUserSettingsDao(database);
  }

  Future<void> insertOrUpdateUserSetting(
      String key, String value, String userId) async {
    try {
      await appUserSettingsDao.insertOrUpdateUserSetting(key, value, userId);
    } catch (e) {
      debugPrint('Error inserting or updating user setting: $e');
      rethrow;
    }
  }

  Future<String?> getUserSetting(String key, String userId) async {
    try {
      return await appUserSettingsDao.getUserSetting(key, userId);
    } catch (e) {
      debugPrint('Error fetching user setting: $e');
      return null;
    }
  }

  Future<Map<String, String>> getAllSettings(String userId) async {
    try {
      return await appUserSettingsDao.getAllSettings(userId);
    } catch (e) {
      debugPrint('Error fetching all user settings: $e');
      return {};
    }
  }

  Future<void> clearUserSettings(String userId) async {
    try {
      await appUserSettingsDao.clearUserSettings(userId);
    } catch (e) {
      debugPrint('Error clearing user settings: $e');
      throw Exception('Failed to clear user settings');
    }
  }

  Future<void> clearUserData(String userId) async {
    try {
      await appUsersDao.clearUserData(userId);
    } catch (e) {
      debugPrint('Error clearing user data: $e');
      throw Exception('Failed to clear user data');
    }
  }

  Future<void> insertUser(User.User user) async {
    try {
      await Supabase.instance.client
          .from('user')
          .upsert(user.toMap(), onConflict: 'user_id');
    } catch (e) {
      debugPrint('Error inserting user: $e');
      throw Exception('Failed to insert user');
    }
  }

  Future<User.User?> getUserById(String id) async {
    try {
      return await appUsersDao.getUserById(id);
    } catch (e) {
      debugPrint('Error fetching user by ID: $e');
      return null;
    }
  }

  Future<void> updateUser(User.User user) async {
    try {
      await appUsersDao.updateUser(user);
    } catch (e) {
      debugPrint('Error updating user: $e');
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await appUsersDao.deleteUser(id);
    } catch (e) {
      debugPrint('Error deleting user: $e');
      throw Exception('Failed to delete user');
    }
  }

  Future<void> clearAllData() async {
    try {
      await database.clearAllData();
    } catch (e) {
      debugPrint('Error clearing all data: $e');
      throw Exception('Failed to clear all data');
    }
  }
}
