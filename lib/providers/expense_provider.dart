import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/database_service.dart';

class ExpenseProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  List<Expense> _expenses = [];
  double _budgetLimit = 5000.0;

  List<Expense> get expenses => _expenses;
  double get budgetLimit => _budgetLimit;

  double get totalExpenses =>
      _expenses.fold(0.0, (sum, item) => sum + item.amount);

  double get remainingBudget => _budgetLimit - totalExpenses;

  Map<String, double> get categoryTotals {
    final map = <String, double>{};
    for (final expense in _expenses) {
      map[expense.category] = (map[expense.category] ?? 0) + expense.amount;
    }
    return map;
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

  Future<void> updateLimit(double newLimit) async {
    _budgetLimit = newLimit;
    await _dbService.saveBudgetLimit(newLimit);
    notifyListeners();
  }
}