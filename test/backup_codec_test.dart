import 'package:bbuddy/models/expense.dart';
import 'package:bbuddy/models/transaction_kind.dart';
import 'package:bbuddy/services/backup_codec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/src/adapters/date_time_adapter.dart';
import 'package:hive/src/binary/binary_reader_impl.dart';
import 'package:hive/src/binary/binary_writer_impl.dart';
import 'package:hive/src/registry/type_registry_impl.dart';

void main() {
  test('backup round-trips income and expenses', () {
    final original = [
      Expense(
        id: 'e1',
        title: 'Market',
        amount: 120.5,
        date: DateTime(2026, 10, 2, 9, 30),
        category: 'grocery',
      ),
      Expense(
        id: 'i1',
        title: 'Harçlık',
        amount: 4000,
        date: DateTime(2026, 10, 1),
        category: 'allowance',
        kind: TransactionKind.income,
      ),
    ];

    final decoded = BackupCodec.decode(
      BackupCodec.encode(budgetLimit: 7500, transactions: original),
    );

    expect(decoded.budgetLimit, 7500);
    expect(decoded.transactions, hasLength(2));
    expect(decoded.transactions.first.kind, TransactionKind.income);
    expect(decoded.transactions.last.category, 'grocery');
    expect(decoded.transactions.last.kind, TransactionKind.expense);
  });

  test('missing kind in a backup is treated as an expense', () {
    const raw = '''
{
  "app": "bbuddy",
  "formatVersion": 1,
  "budgetLimit": 1000,
  "transactions": [
    {
      "id": "x",
      "title": "Yemek",
      "amount": 50,
      "date": "2026-10-03T12:00:00.000",
      "category": "food"
    }
  ]
}
''';
    final decoded = BackupCodec.decode(raw);
    expect(decoded.transactions.single.isIncome, isFalse);
  });

  test('rejects a file that is not a BBuddy backup', () {
    expect(
      () => BackupCodec.decode('{"app":"other","formatVersion":1}'),
      throwsA(
        isA<BackupFormatException>().having(
          (error) => error.code,
          'code',
          BackupError.invalid,
        ),
      ),
    );
  });

  test('rejects a newer backup version', () {
    expect(
      () => BackupCodec.decode(
        '{"app":"bbuddy","formatVersion":2,"budgetLimit":1,"transactions":[]}',
      ),
      throwsA(
        isA<BackupFormatException>().having(
          (error) => error.code,
          'code',
          BackupError.version,
        ),
      ),
    );
  });

  test('records saved before income support still load', () {
    final registry = TypeRegistryImpl()
      ..registerAdapter(DateTimeWithTimezoneAdapter(), internal: true);
    final writer = BinaryWriterImpl(registry);
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write('legacy')
      ..writeByte(1)
      ..write('Market')
      ..writeByte(2)
      ..write(42.0)
      ..writeByte(3)
      ..write(DateTime(2026, 4, 1))
      ..writeByte(4)
      ..write('grocery');

    final expense = ExpenseAdapter().read(
      BinaryReaderImpl(writer.toBytes(), registry),
    );

    expect(expense.id, 'legacy');
    expect(expense.amount, 42);
    expect(expense.category, 'grocery');
    expect(expense.kind, TransactionKind.expense);
    expect(expense.isIncome, isFalse);
  });
}
