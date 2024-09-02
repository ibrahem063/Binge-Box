import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    if (sharedPreferences == null) {
      throw Exception("SharedPreferences is not initialized");
    }
    return await sharedPreferences!.remove(key);
  }

  static dynamic getData({
    required String key,
  }) {
    if (sharedPreferences == null) {
      throw Exception("SharedPreferences is not initialized");
    }
    return sharedPreferences!.get(key);
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (sharedPreferences == null) {
      throw Exception("SharedPreferences is not initialized");
    }

    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is double) return await sharedPreferences!.setDouble(key, value);
    if (value is List<String>) return await sharedPreferences!.setStringList(key, value);

    throw Exception("Unsupported value type");
  }
}
