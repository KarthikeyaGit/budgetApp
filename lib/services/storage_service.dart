import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveData(String key, String value) async {
    print("key ${key}  value  ${value}");
    await _prefs.setString(key, value);
  }

  static String getData(String key) {
    return _prefs.getString(key) ?? '';
  }
}
