/// Distinguishes money going out from money coming in.
abstract final class TransactionKind {
  static const expense = 'expense';
  static const income = 'income';

  static bool isIncome(String kind) => kind == income;

  static String normalize(String? kind) =>
      isIncome(kind ?? '') ? income : expense;
}
