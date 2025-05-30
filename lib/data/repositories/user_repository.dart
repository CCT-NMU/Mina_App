import 'package:flutter/foundation.dart';
import 'package:mina_app/data/model/user.dart';
import 'package:mina_app/data/database/databaseHelper.dart';

class UserRepository {
  UserRepository._privateConstructor();
  final UserRepository _instance = UserRepository._privateConstructor();
  UserRepository get instance => _instance;

  Future<void> insertOrUpdateUserSetting(
      String key, String value, String userId) async {
    try {
      await DatabaseHelper().insertOrUpdateUserSetting(key, value, userId);
    } catch (e) {
      debugPrint('Error inserting or updating user setting: $e');
      rethrow;
    }
  }

  Future<String?> getUserSetting(String key, String userId) async {
    try {
      return await DatabaseHelper().getUserSetting(key, userId);
    } catch (e) {
      debugPrint('Error fetching user setting: $e');
      return null;
    }
  }

  Future<Map<String, String>> getUserSettings(String userId) async {
    try {
      return await DatabaseHelper().getAllSettings(userId);
    } catch (e) {
      debugPrint('Error fetching all user settings: $e');
      return {};
    }
  }

  Future<void> clearUserData(String userId) async {
    try {
      await DatabaseHelper().clearUserData(userId);
    } catch (e) {
      debugPrint('Error clearing user data: $e');
      throw Exception('Failed to clear user data');
    }
  }

  Future<void> clearAllData() async {
    try {
      await DatabaseHelper().clearAllData();
    } catch (e) {
      debugPrint('Error clearing all data: $e');
      throw Exception('Failed to clear all data');
    }
  }
}
