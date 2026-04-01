import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense.dart';

class DatabaseService {
  static const String _expensesBoxName = 'expenses_box';
  static const String _settingsBoxName = 'settings_box';
  static const String _budgetLimitKey = 'budget_limit';
  static const String _onboardingKey = 'onboarding_seen';
  static const String _currencyKey = 'currency_symbol';
  static const String _themeModeKey = 'theme_mode';
  static const String _languageKey = 'language_code';
  static const double _defaultBudgetLimit = 5000.0;

  Future<Box<Expense>> get _expensesBox async =>
      await Hive.openBox<Expense>(_expensesBoxName);

  Future<Box> get _settingsBox async =>
      await Hive.openBox(_settingsBoxName);

  Future<void> addExpense(Expense expense) async {
    final box = await _expensesBox;
    await box.put(expense.id, expense);
  }

  Future<List<Expense>> getAllExpenses() async {
    final box = await _expensesBox;
    return box.values.toList();
  }

  Future<void> updateExpense(Expense expense) async {
    final box = await _expensesBox;
    await box.put(expense.id, expense);
  }

  Future<void> deleteExpense(String id) async {
    final box = await _expensesBox;
    await box.delete(id);
  }

  Future<double> getBudgetLimit() async {
    final box = await _settingsBox;
    return box.get(_budgetLimitKey, defaultValue: _defaultBudgetLimit) as double;
  }

  Future<void> saveBudgetLimit(double limit) async {
    final box = await _settingsBox;
    await box.put(_budgetLimitKey, limit);
  }

  Future<bool> hasSeenOnboarding() async {
    final box = await _settingsBox;
    return box.get(_onboardingKey, defaultValue: false) as bool;
  }

  Future<void> setOnboardingSeen() async {
    final box = await _settingsBox;
    await box.put(_onboardingKey, true);
  }

  Future<String> getCurrencySymbol() async {
    final box = await _settingsBox;
    return box.get(_currencyKey, defaultValue: '₺') as String;
  }

  Future<void> saveCurrencySymbol(String symbol) async {
    final box = await _settingsBox;
    await box.put(_currencyKey, symbol);
  }

  Future<int> getThemeModeIndex() async {
    final box = await _settingsBox;
    return box.get(_themeModeKey, defaultValue: 0) as int;
  }

  Future<void> saveThemeModeIndex(int index) async {
    final box = await _settingsBox;
    await box.put(_themeModeKey, index);
  }

  Future<void> clearAllExpenses() async {
    final box = await _expensesBox;
    await box.clear();
  }

  Future<String> getLanguageCode() async {
    final box = await _settingsBox;
    return box.get(_languageKey, defaultValue: 'tr') as String;
  }

  Future<void> saveLanguageCode(String code) async {
    final box = await _settingsBox;
    await box.put(_languageKey, code);
  }
}