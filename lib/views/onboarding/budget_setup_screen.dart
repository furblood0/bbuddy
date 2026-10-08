import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/amount_formatter.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/expense_provider.dart';
import '../../services/database_service.dart';
import '../main_screen.dart';

class BudgetSetupScreen extends StatefulWidget {
  const BudgetSetupScreen({super.key});

  @override
  State<BudgetSetupScreen> createState() => _BudgetSetupScreenState();
}

class _BudgetSetupScreenState extends State<BudgetSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final limit = context.read<ExpenseProvider>().budgetLimit;
    _controller = TextEditingController(text: limit.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _continue(AppLocalizations l) async {
    if (!_formKey.currentState!.validate()) return;
    final amount = double.tryParse(_controller.text.replaceAll(',', '.')) ?? 0;
    await context.read<ExpenseProvider>().updateLimit(amount);
    await DatabaseService().setOnboardingSeen();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  l.budgetSetupTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  l.budgetSetupSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
                TextFormField(
                  controller: _controller,
                  autofocus: true,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: l.settingsMonthlyBudgetLimit,
                    suffixText: currencySymbol,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l.settingsEnterLimit;
                    }
                    final amount = double.tryParse(value.replaceAll(',', '.'));
                    if (amount == null || amount <= 0) {
                      return l.settingsEnterValidAmount;
                    }
                    return null;
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => _continue(l),
                    child: Text(l.budgetSetupContinue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
