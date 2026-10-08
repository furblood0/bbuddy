import 'dart:convert';

import '../models/expense.dart';
import '../models/transaction_kind.dart';

abstract final class BackupError {
  static const invalid = 'invalid';
  static const version = 'version';
  static const empty = 'empty';
}

class BackupFormatException implements Exception {
  final String code;

  const BackupFormatException(this.code);
}

class BackupPayload {
  final double budgetLimit;
  final List<Expense> transactions;

  const BackupPayload({required this.budgetLimit, required this.transactions});
}

/// JSON backup of the budget limit and every income or expense record.
abstract final class BackupCodec {
  static const formatVersion = 1;
  static const appId = 'bbuddy';
  static const maxBytes = 2 * 1024 * 1024;

  static String encode({
    required double budgetLimit,
    required List<Expense> transactions,
    DateTime? exportedAt,
  }) {
    final ordered = [...transactions]..sort((a, b) => a.date.compareTo(b.date));
    final payload = {
      'app': appId,
      'formatVersion': formatVersion,
      'exportedAt': (exportedAt ?? DateTime.now()).toIso8601String(),
      'budgetLimit': budgetLimit,
      'transactions': [
        for (final item in ordered)
          {
            'id': item.id,
            'title': item.title,
            'amount': item.amount,
            'date': item.date.toIso8601String(),
            'category': item.category,
            'kind': TransactionKind.normalize(item.kind),
          },
      ],
    };
    return const JsonEncoder.withIndent('  ').convert(payload);
  }

  static BackupPayload decode(String source) {
    if (source.trim().isEmpty) {
      throw const BackupFormatException(BackupError.empty);
    }
    if (source.length > maxBytes) {
      throw const BackupFormatException(BackupError.invalid);
    }

    final Object? decoded;
    try {
      decoded = jsonDecode(source);
    } on FormatException {
      throw const BackupFormatException(BackupError.invalid);
    }
    if (decoded is! Map) {
      throw const BackupFormatException(BackupError.invalid);
    }

    final map = Map<String, dynamic>.from(decoded);
    if (map['app'] != appId) {
      throw const BackupFormatException(BackupError.invalid);
    }

    final version = map['formatVersion'];
    if (version is! num) {
      throw const BackupFormatException(BackupError.invalid);
    }
    if (version > formatVersion) {
      throw const BackupFormatException(BackupError.version);
    }
    if (version < 1) {
      throw const BackupFormatException(BackupError.invalid);
    }

    final limit = map['budgetLimit'];
    if (limit is! num || limit <= 0) {
      throw const BackupFormatException(BackupError.invalid);
    }

    final rawItems = map['transactions'];
    if (rawItems is! List) {
      throw const BackupFormatException(BackupError.invalid);
    }

    final transactions = <Expense>[];
    for (final raw in rawItems) {
      if (raw is! Map) {
        throw const BackupFormatException(BackupError.invalid);
      }
      transactions.add(_transaction(Map<String, dynamic>.from(raw)));
    }

    return BackupPayload(
      budgetLimit: limit.toDouble(),
      transactions: transactions,
    );
  }

  static Expense _transaction(Map<String, dynamic> raw) {
    final title = raw['title'];
    final amount = raw['amount'];
    final date = raw['date'];
    final category = raw['category'];
    final id = raw['id'];

    if (title is! String || title.trim().isEmpty) {
      throw const BackupFormatException(BackupError.invalid);
    }
    if (amount is! num || amount <= 0) {
      throw const BackupFormatException(BackupError.invalid);
    }
    if (date is! String) {
      throw const BackupFormatException(BackupError.invalid);
    }
    final parsedDate = DateTime.tryParse(date);
    if (parsedDate == null) {
      throw const BackupFormatException(BackupError.invalid);
    }
    if (category is! String || category.trim().isEmpty) {
      throw const BackupFormatException(BackupError.invalid);
    }

    final rawKind = raw['kind'];
    if (rawKind != null && rawKind is! String) {
      throw const BackupFormatException(BackupError.invalid);
    }

    return Expense(
      id: id is String && id.trim().isNotEmpty ? id.trim() : null,
      title: title.trim(),
      amount: amount.toDouble(),
      date: parsedDate,
      category: category.trim(),
      kind: TransactionKind.normalize(rawKind as String?),
    );
  }
}
