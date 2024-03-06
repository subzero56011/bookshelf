import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBool({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    final storedValue = sharedPreferences!.get(key);
    return storedValue != null;
  }

  static dynamic getActualData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> saveDate({
    required String key,
    dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);

    return await sharedPreferences!.setDouble(key, value);
  }

  static Future<bool> setStringList({
    required String key,
    dynamic value,
  }) async {
    return await sharedPreferences!.setStringList(key, value);
  }

  static Future<List<String>?> getStringList({
    required String key,
    dynamic value,
  }) async {
    return await sharedPreferences!.getStringList(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }
}
