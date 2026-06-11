import 'package:smart_sport_club/core/local/shared_pref.dart';

class ThemeRepo {
  static const String themeModeKey = 'theme_mode';
  static const String darkModeValue = 'dark';
  static const String lightModeValue = 'light';

  String getSavedThemeMode() {
    return SharedPref.getString(themeModeKey).trim();
  }

  bool get isDarkModeSaved => getSavedThemeMode() == darkModeValue;

  Future<void> saveThemeMode({required bool isDarkMode}) async {
    await SharedPref.setString(
      themeModeKey,
      isDarkMode ? darkModeValue : lightModeValue,
    );
  }
}
