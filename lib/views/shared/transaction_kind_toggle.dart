import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/transaction_kind.dart';

class TransactionKindToggle extends StatelessWidget {
  final String kind;
  final ValueChanged<String> onChanged;

  const TransactionKindToggle({
    super.key,
    required this.kind,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return SegmentedButton<String>(
      showSelectedIcon: false,
      segments: [
        ButtonSegment(
          value: TransactionKind.expense,
          label: Text(l.kindExpense),
          icon: const Icon(Icons.remove_rounded, size: 18),
        ),
        ButtonSegment(
          value: TransactionKind.income,
          label: Text(l.kindIncome),
          icon: const Icon(Icons.add_rounded, size: 18),
        ),
      ],
      selected: {kind},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
