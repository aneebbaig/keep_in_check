import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String hasOnboarded = 'hasOnboarded';
  static const String isLoggedIn = 'isLoggedIn';

  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Methods for reading and writing data

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  int? getInt(String key, {int? defaultValue}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  bool getBool(String key, {required bool defaultValue}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  // Add more methods for other data types as needed

  // Example method to clear all preferences
  Future<void> clear() async {
    await _preferences.clear();
  }
}
