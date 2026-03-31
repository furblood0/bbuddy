import 'package:flutter/material.dart';

import '../services/database_service.dart';

class SettingsProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  String _currencySymbol = '₺';
  ThemeMode _themeMode = ThemeMode.system;

  String get currencySymbol => _currencySymbol;
  ThemeMode get themeMode => _themeMode;

  static const List<Map<String, String>> currencies = [
    {'symbol': '₺', 'name': 'Türk Lirası', 'code': 'TRY'},
    {'symbol': '\$', 'name': 'US Dollar', 'code': 'USD'},
    {'symbol': '€', 'name': 'Euro', 'code': 'EUR'},
    {'symbol': '£', 'name': 'Pound Sterling', 'code': 'GBP'},
    {'symbol': '¥', 'name': 'Japanese Yen', 'code': 'JPY'},
    {'symbol': 'Fr', 'name': 'Swiss Franc', 'code': 'CHF'},
    {'symbol': '₽', 'name': 'Russian Ruble', 'code': 'RUB'},
  ];

  Future<void> loadSettings() async {
    _currencySymbol = await _dbService.getCurrencySymbol();
    final index = await _dbService.getThemeModeIndex();
    _themeMode = ThemeMode.values[index];
    notifyListeners();
  }

  Future<void> updateCurrency(String symbol) async {
    _currencySymbol = symbol;
    await _dbService.saveCurrencySymbol(symbol);
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _dbService.saveThemeModeIndex(mode.index);
    notifyListeners();
  }
}
