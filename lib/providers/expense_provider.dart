import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/database_service.dart';

class ExpenseProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  List<Expense> _expenses = [];
  double _budgetLimit = 5000.0;

  List<Expense> get expenses => _expenses;
  double get budgetLimit => _budgetLimit;

  static bool isSameMonth(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month;

  List<Expense> get currentMonthTransactions =>
      _sorted(_inMonth(DateTime.now()));

  List<Expense> get currentMonthExpenses =>
      currentMonthTransactions.where((e) => !e.isIncome).toList();

  List<Expense> get currentMonthIncomes =>
      currentMonthTransactions.where((e) => e.isIncome).toList();

  double get totalExpenses =>
      currentMonthExpenses.fold(0.0, (sum, item) => sum + item.amount);

  double get totalIncome =>
      currentMonthIncomes.fold(0.0, (sum, item) => sum + item.amount);

  double get remainingBudget => _budgetLimit - totalExpenses;

  double get netBalance => totalIncome - totalExpenses;

  static DateTime monthKey(DateTime date) => DateTime(date.year, date.month);

  List<DateTime> get monthsWithExpenses {
    final months = <String, DateTime>{};
    for (final expense in _expenses) {
      final key = monthKey(expense.date);
      months['${key.year}-${key.month}'] = key;
    }
    return months.values.toList()..sort((a, b) => b.compareTo(a));
  }

  List<Expense> expensesForMonth(DateTime month) =>
      _inMonth(month).where((e) => !e.isIncome).toList();

  double incomeForMonth(DateTime month) => _inMonth(
    month,
  ).where((e) => e.isIncome).fold(0.0, (sum, item) => sum + item.amount);

  List<Expense> _inMonth(DateTime month) =>
      _expenses.where((e) => isSameMonth(e.date, month)).toList();

  List<Expense> _sorted(List<Expense> items) {
    final copy = [...items];
    copy.sort((a, b) {
      final byDate = b.date.compareTo(a.date);
      if (byDate != 0) return byDate;
      return b.id.compareTo(a.id);
    });
    return copy;
  }

  Future<void> loadExpenses() async {
    _expenses = await _dbService.getAllExpenses();
    _budgetLimit = await _dbService.getBudgetLimit();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await _dbService.addExpense(expense);
    _expenses.add(expense);
    notifyListeners();
  }

  Future<void> updateExpense(Expense updated) async {
    await _dbService.updateExpense(updated);
    final index = _expenses.indexWhere((e) => e.id == updated.id);
    if (index != -1) _expenses[index] = updated;
    notifyListeners();
  }

  Future<void> deleteExpense(String id) async {
    await _dbService.deleteExpense(id);
    _expenses.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> clearAllExpenses() async {
    await _dbService.clearAllExpenses();
    _expenses.clear();
    notifyListeners();
  }

  Future<void> replaceAll({
    required List<Expense> transactions,
    required double budgetLimit,
  }) async {
    await _dbService.replaceAll(transactions, budgetLimit);
    _expenses = List<Expense>.from(transactions);
    _budgetLimit = budgetLimit;
    notifyListeners();
  }

  Future<void> updateLimit(double newLimit) async {
    _budgetLimit = newLimit;
    await _dbService.saveBudgetLimit(newLimit);
    notifyListeners();
  }
}
