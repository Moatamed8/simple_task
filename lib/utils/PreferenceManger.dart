import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static PreferenceManager instance;

  void saveString(String key, String value) async {
    var prefs = await _prefs;
    prefs.setString(key, value);
  }

  void saveBoolean(String key, bool value) async {
    var prefs = await _prefs;
    prefs.setBool(key, value);
  }

  void saveInt(String key, int value) async {
    var prefs = await _prefs;
    prefs.setInt(key, value);
  }

  void saveDouble(String key, double value) async {
    var prefs = await _prefs;
    prefs.setDouble(key, value);
  }

  void remove(String key) async {
    var prefs = await _prefs;
    prefs.remove(key);
  }

  Future<String> getString(String key) async {
    var prefs = await _prefs;
    if (prefs.containsKey(key)) return prefs.getString(key);
    return "";
  }

  Future<bool> getBoolean(String key) async {
    var prefs = await _prefs;
    if (prefs.containsKey(key))
      return prefs.getBool(key);
    else
      return false;
  }

  Future<int> getInt(String key) async {
    var prefs = await _prefs;
    return prefs.getInt(key) ?? -1;
  }

  Future<double> getDouble(String key) async {
    var prefs = await _prefs;
    return prefs.getDouble(key) ?? -1;
  }

  static PreferenceManager getInstance() {
    if (instance == null) instance = PreferenceManager();

    return instance;
  }
}
