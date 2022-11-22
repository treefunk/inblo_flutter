import 'dart:async' show Future;
import 'package:inblo_app/models/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ?? await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // static const String _userDetails = "user_details";

  static const String _keyUserId = "user_id";
  static const String _keyStableId = "stable_Id";
  static const String _keyRoleId = "role_id";
  static const String _keyUsername = "username";

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, [String defValue = ""]) {
    return _prefsInstance?.getString(key) ?? defValue;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> setUserDetails(UserDetails userDetails) async {
    var prefs = await _instance;

    prefs.setInt(_keyUserId, userDetails.userId);
    prefs.setInt(_keyStableId, userDetails.stableId);
    prefs.setInt(_keyRoleId, userDetails.roleId);
    prefs.setString(_keyUsername, userDetails.username);

    return true;
  }

  static Future<bool> clearPreferences() async {
    var prefs = await _instance;

    return prefs.clear();
  }

  static Future<UserDetails> getUserDetails() async {
    var prefs = await _instance;

    return UserDetails(
      userId: prefs.getInt(_keyUserId) ?? -1,
      username: prefs.getString(_keyUsername) ?? "Guest",
      stableId: prefs.getInt(_keyStableId) ?? -1,
      roleId: prefs.getInt(_keyRoleId) ?? -1,
    );
  }

  static Future<int?> getUserId() async {
    var prefs = await _instance;

    return prefs.getInt(_keyUserId);
  }
}
