import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'transaction_kind.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String category;

  /// `expense` or `income`. Missing on records saved before income support.
  @HiveField(5, defaultValue: 'expense')
  final String kind;

  Expense({
    String? id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    this.kind = TransactionKind.expense,
  }) : id = id ?? const Uuid().v4();

  bool get isIncome => TransactionKind.isIncome(kind);
}
