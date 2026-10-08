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

class EditExpenseSheet extends StatefulWidget {
  final Expense expense;

  const EditExpenseSheet({super.key, required this.expense});

  @override
  State<EditExpenseSheet> createState() => _EditExpenseSheetState();
}

class _EditExpenseSheetState extends State<EditExpenseSheet> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  final _formKey = GlobalKey<FormState>();
  late String _selectedCategory;
  late String _kind;
  late DateTime _selectedDate;
  bool _titleInitialized = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _amountController = TextEditingController(
      text: widget.expense.amount.toStringAsFixed(2).replaceAll('.', ','),
    );
    _selectedCategory = CategoryHelper.normalize(
      widget.expense.category,
      kind: widget.expense.kind,
    );
    _kind = TransactionKind.normalize(widget.expense.kind);
    _selectedDate = widget.expense.date;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_titleInitialized) return;

    final l = AppLocalizations.of(context)!;
    if (!CategoryHelper.isDefaultTitle(
      widget.expense.title,
      widget.expense.category,
      l,
      kind: widget.expense.kind,
    )) {
      _titleController.text = widget.expense.title;
    }
    _titleInitialized = true;
  }

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

    final updatedExpense = Expense(
      id: widget.expense.id,
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

    context.read<ExpenseProvider>().updateExpense(updatedExpense);
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
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
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
                Row(
                  children: [
                    Text(
                      isIncome ? l.editIncomeTitle : l.editExpenseTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                              isIncome
                                  ? l.editIncomeDeleteTitle
                                  : l.editExpenseDeleteTitle,
                            ),
                            content: Text(
                              isIncome
                                  ? l.editIncomeDeleteConfirm
                                  : l.editExpenseDeleteConfirm,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(),
                                child: Text(l.cancel),
                              ),
                              FilledButton(
                                onPressed: () {
                                  context.read<ExpenseProvider>().deleteExpense(
                                    widget.expense.id,
                                  );
                                  Navigator.of(ctx).pop();
                                  Navigator.of(context).pop();
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: Text(l.delete),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      tooltip: l.delete,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: l.addExpenseAmount,
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
                    child: Text(l.update),
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
