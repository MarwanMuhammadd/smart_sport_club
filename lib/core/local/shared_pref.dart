import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  static late SharedPreferences sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String KToken = "Token";

  static Future<void> setToken(String? value) async {
    if (value == null) return;
    await setString(KToken, value);
  }

  static String getToken() {
    return getString(KToken);
  }

  static Future<void> setString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  static String getString(String key) {
    return sharedPreferences.getString(key) ?? " ";
  }
}
