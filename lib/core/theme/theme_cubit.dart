import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/theme/theme_repo.dart';
import 'package:smart_sport_club/core/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._themeRepo) : super(ThemeState(isDarkMode: _themeRepo.isDarkModeSaved));

  final ThemeRepo _themeRepo;

  void loadSavedTheme() {
    emit(ThemeState(isDarkMode: _themeRepo.isDarkModeSaved));
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    emit(ThemeState(isDarkMode: isDarkMode));
    await _themeRepo.saveThemeMode(isDarkMode: isDarkMode);
  }
}
