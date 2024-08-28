import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  // Save a String value
  Future<void> save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Get a String value
  Future<String?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key); // Retrieve the string value associated with the key
  }

}

