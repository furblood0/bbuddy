import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_styles.dart';
import '../../../core/category_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/expense.dart';
import '../../../models/transaction_kind.dart';
import '../../../providers/expense_provider.dart';
import '../../../providers/settings_provider.dart';
import '../../shared/category_picker.dart';
import '../../shared/transaction_kind_toggle.dart';
import 'expense_date_field.dart';

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedCategory = CategoryHelper.defaultCategory;
  String _kind = TransactionKind.expense;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitData(AppLocalizations l) {
    if (!_formKey.currentState!.validate()) return;

    final amount =
        double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0;

    final category = CategoryHelper.normalize(_selectedCategory, kind: _kind);

    final newExpense = Expense(
      title: CategoryHelper.resolveTitle(
        _titleController.text,
        category,
        l,
        kind: _kind,
      ),
      amount: amount,
      date: _selectedDate,
      category: category,
      kind: _kind,
    );

    context.read<ExpenseProvider>().addExpense(newExpense);
    Navigator.of(context).pop();
  }

  void _onKindChanged(String kind) {
    setState(() {
      _kind = kind;
      if (!CategoryHelper.categoriesFor(kind).contains(_selectedCategory)) {
        _selectedCategory = CategoryHelper.defaultFor(kind);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final locale = context.watch<SettingsProvider>().locale.languageCode;

    final isIncome = _kind == TransactionKind.income;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyles.sheetHandle(context),
              const SizedBox(height: 20),
              Text(
                isIncome ? l.addIncomeTitle : l.addExpenseTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TransactionKindToggle(kind: _kind, onChanged: _onKindChanged),
              const SizedBox(height: 20),
              Text(
                l.addExpenseCategory,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 10),
              CategoryPicker(
                kind: _kind,
                selectedCategory: _selectedCategory,
                onCategoryChanged: (category) =>
                    setState(() => _selectedCategory = category),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: l.addExpenseAmount,
                  hintText: l.addExpenseAmountHint,
                  prefixIcon: const Icon(Icons.payments_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l.addExpenseEnterAmount;
                  }
                  final amount = double.tryParse(value.replaceAll(',', '.'));
                  if (amount == null || amount <= 0) {
                    return l.addExpenseEnterValidAmount;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              ExpenseDateField(
                selectedDate: _selectedDate,
                onDateChanged: (date) => setState(() => _selectedDate = date),
                label: l.addExpenseDate,
                locale: locale,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: l.addExpenseTitleLabel,
                  hintText: isIncome
                      ? l.addIncomeTitleHint
                      : l.addExpenseTitleHint,
                  prefixIcon: const Icon(Icons.notes_outlined),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _submitData(l),
                  child: Text(l.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
