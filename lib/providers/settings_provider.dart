import 'package:flutter/material.dart';

import '../services/database_service.dart';

class SettingsProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('tr');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  Future<void> loadSettings() async {
    final index = await _dbService.getThemeModeIndex();
    _themeMode = ThemeMode.values[index];
    final langCode = await _dbService.getLanguageCode();
    _locale = Locale(langCode);
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _dbService.saveThemeModeIndex(mode.index);
    notifyListeners();
  }

  Future<void> updateLocale(Locale locale) async {
    _locale = locale;
    await _dbService.saveLanguageCode(locale.languageCode);
    notifyListeners();
  }
}
