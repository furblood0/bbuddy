import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/app_styles.dart';
import '../../core/amount_formatter.dart';
import '../../core/category_helper.dart';
import '../../l10n/app_localizations.dart';
import '../../models/expense.dart';
import '../../providers/expense_provider.dart';
import '../../providers/settings_provider.dart';
import '../settings/settings_screen.dart';
import '../shared/empty_state.dart';
import '../shared/screen_header.dart';
import 'widgets/add_expense_sheet.dart';
import 'widgets/edit_expense_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<ExpenseProvider>().loadExpenses();
    });
  }

  String _formatDate(DateTime date, String locale) {
    return DateFormat('d MMM y', locale).format(date);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final provider = context.watch<ExpenseProvider>();
    final locale = context.watch<SettingsProvider>().locale.languageCode;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: ScreenHeader(
        icon: Icons.account_balance_wallet_rounded,
        title: 'BBuddy',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const SettingsScreen())),
            tooltip: l.homeSettings,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBudgetCard(provider, colorScheme, l),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppStyles.pagePadding + 4,
            ),
            child: Row(
              children: [
                Text(
                  l.homeRecords,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  l.homeExpenseCount(provider.currentMonthTransactions.length),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colorScheme.outline),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: provider.currentMonthTransactions.isEmpty
                ? _buildEmptyState(colorScheme, l)
                : _buildExpenseList(provider, colorScheme, locale, l),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (ctx) => const AddExpenseSheet(),
        ),
        icon: const Icon(Icons.add_rounded),
        label: Text(l.homeAddRecord),
      ),
    );
  }

  Widget _buildBudgetCard(
    ExpenseProvider provider,
    ColorScheme colorScheme,
    AppLocalizations l,
  ) {
    final progress = (provider.totalExpenses / provider.budgetLimit).clamp(
      0.0,
      1.0,
    );
    final isOverBudget = provider.remainingBudget < 0;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppStyles.pagePadding,
        4,
        AppStyles.pagePadding,
        0,
      ),
      padding: const EdgeInsets.all(24),
      decoration: AppStyles.budgetCard(
        isOverBudget: isOverBudget,
        isDark: isDark,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.homeRemainingBudget,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isOverBudget ? l.homeBudgetExceeded : l.homeThisMonth,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            formatAmount(provider.remainingBudget),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              valueColor: AlwaysStoppedAnimation<Color>(
                isOverBudget ? Colors.red.shade200 : Colors.white,
              ),
              minHeight: 7,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.homeBudgetUsedPercent((progress * 100).toStringAsFixed(0)),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
              Text(
                '${formatAmount(provider.totalExpenses)} / ${formatAmount(provider.budgetLimit)}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _cashflowStat(l.homeIncome, formatAmount(provider.totalIncome)),
              _cashflowStat(l.homeSpent, formatAmount(provider.totalExpenses)),
              _cashflowStat(
                l.homeNet,
                formatAmount(provider.netBalance),
                emphasize: provider.netBalance < 0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cashflowStat(String label, String value, {bool emphasize = false}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: emphasize ? Colors.red.shade100 : Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme, AppLocalizations l) {
    return EmptyState(
      icon: Icons.receipt_long_outlined,
      title: l.homeNoExpensesTitle,
      subtitle: l.homeNoExpensesSubtitle,
    );
  }

  Widget _buildExpenseList(
    ExpenseProvider provider,
    ColorScheme colorScheme,
    String locale,
    AppLocalizations l,
  ) {
    final records = provider.currentMonthTransactions;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppStyles.pagePadding,
        0,
        AppStyles.pagePadding,
        100,
      ),
      itemCount: records.length,
      itemBuilder: (context, index) =>
          _buildExpenseItem(records[index], provider, colorScheme, locale, l),
    );
  }

  Widget _buildExpenseItem(
    Expense expense,
    ExpenseProvider provider,
    ColorScheme colorScheme,
    String locale,
    AppLocalizations l,
  ) {
    final income = expense.isIncome;
    final categoryColor = CategoryHelper.getColor(
      expense.category,
      kind: expense.kind,
    );

    return Dismissible(
      key: Key(expense.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(AppStyles.radiusLg),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.delete_outline, color: Colors.white, size: 22),
            const SizedBox(height: 2),
            Text(
              l.homeSwipeToDelete,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
      ),
      onDismissed: (_) {
        provider.deleteExpense(expense.id);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l.homeRecordDeleted),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            action: SnackBarAction(
              label: l.homeUndo,
              onPressed: () => provider.addExpense(expense),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: AppStyles.surfaceCard(context),
        child: ListTile(
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (_) => EditExpenseSheet(expense: expense),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              CategoryHelper.getIcon(expense.category, kind: expense.kind),
              color: categoryColor,
              size: 22,
            ),
          ),
          title: Text(
            expense.title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              CategoryHelper.isDefaultTitle(
                    expense.title,
                    expense.category,
                    l,
                    kind: expense.kind,
                  )
                  ? _formatDate(expense.date, locale)
                  : '${CategoryHelper.displayName(expense.category, l, kind: expense.kind)} • ${_formatDate(expense.date, locale)}',
              style: TextStyle(fontSize: 12, color: colorScheme.outline),
            ),
          ),
          trailing: Text(
            '${income ? '+' : '-'}${formatAmount(expense.amount)}',
            style: TextStyle(
              color: income
                  ? (Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF6EE7B7)
                        : const Color(0xFF047857))
                  : colorScheme.error,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
