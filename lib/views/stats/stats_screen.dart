import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/app_styles.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/expense_provider.dart';
import '../../providers/settings_provider.dart';
import '../shared/empty_state.dart';
import '../shared/screen_header.dart';
import '../shared/monthly_stats_view.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  DateTime? _selectedMonth;

  DateTime _resolveSelectedMonth(List<DateTime> months) {
    if (_selectedMonth != null &&
        months.any(
          (month) => ExpenseProvider.isSameMonth(month, _selectedMonth!),
        )) {
      return _selectedMonth!;
    }

    final now = DateTime.now();
    for (final month in months) {
      if (ExpenseProvider.isSameMonth(month, now)) return month;
    }
    return months.first;
  }

  String _formatMonth(DateTime month, String locale) {
    return DateFormat('MMMM yyyy', locale).format(month);
  }

  void _showMonthPicker(
    AppLocalizations l,
    List<DateTime> months,
    DateTime selectedMonth,
    String locale,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l.statsSelectMonth,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: months.length,
                  itemBuilder: (context, index) {
                    final month = months[index];
                    final isSelected = ExpenseProvider.isSameMonth(
                      month,
                      selectedMonth,
                    );
                    return ListTile(
                      onTap: () {
                        setState(() => _selectedMonth = month);
                        Navigator.of(ctx).pop();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text(
                        _formatMonth(month, locale),
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final provider = context.watch<ExpenseProvider>();
    final locale = context.watch<SettingsProvider>().locale.languageCode;
    final colorScheme = Theme.of(context).colorScheme;
    final months = provider.monthsWithExpenses;

    return Scaffold(
      appBar: ScreenHeader(icon: Icons.insights_rounded, title: l.statsTitle),
      body: months.isEmpty
          ? _buildEmptyState(colorScheme, l)
          : _buildContent(
              provider,
              months,
              _resolveSelectedMonth(months),
              colorScheme,
              locale,
              l,
            ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme, AppLocalizations l) {
    return EmptyState(
      icon: Icons.pie_chart_outline_rounded,
      title: l.statsNoDataTitle,
      subtitle: l.statsNoDataSubtitle,
    );
  }

  Widget _buildContent(
    ExpenseProvider provider,
    List<DateTime> months,
    DateTime selectedMonth,
    ColorScheme colorScheme,
    String locale,
    AppLocalizations l,
  ) {
    final monthExpenses = provider.expensesForMonth(selectedMonth);
    final selectedIndex = months.indexWhere(
      (month) => ExpenseProvider.isSameMonth(month, selectedMonth),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppStyles.pagePadding,
        0,
        AppStyles.pagePadding,
        32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMonthFilter(
            months,
            selectedIndex,
            selectedMonth,
            colorScheme,
            locale,
            l,
          ),
          const SizedBox(height: 20),
          MonthlyStatsView(
            expenses: monthExpenses,
            incomeTotal: provider.incomeForMonth(selectedMonth),
            budgetLimit: provider.budgetLimit,
            l: l,
          ),
        ],
      ),
    );
  }

  Widget _buildMonthFilter(
    List<DateTime> months,
    int selectedIndex,
    DateTime selectedMonth,
    ColorScheme colorScheme,
    String locale,
    AppLocalizations l,
  ) {
    final canGoNewer = selectedIndex > 0;
    final canGoOlder = selectedIndex < months.length - 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: AppStyles.surfaceCard(context),
      child: Row(
        children: [
          IconButton(
            onPressed: canGoOlder
                ? () =>
                      setState(() => _selectedMonth = months[selectedIndex + 1])
                : null,
            icon: const Icon(Icons.chevron_left),
            tooltip: l.statsPreviousMonth,
          ),
          Expanded(
            child: InkWell(
              onTap: () => _showMonthPicker(l, months, selectedMonth, locale),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Text(
                      _formatMonth(selectedMonth, locale),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l.statsSelectMonth,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: canGoNewer
                ? () =>
                      setState(() => _selectedMonth = months[selectedIndex - 1])
                : null,
            icon: const Icon(Icons.chevron_right),
            tooltip: l.statsNextMonth,
          ),
        ],
      ),
    );
  }
}
