import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/app_styles.dart';
import '../../core/amount_formatter.dart';
import '../../core/category_helper.dart';
import '../../l10n/app_localizations.dart';
import '../../models/expense.dart';

class MonthlyStatsView extends StatefulWidget {
  final List<Expense> expenses;
  final double incomeTotal;
  final double budgetLimit;
  final AppLocalizations l;

  const MonthlyStatsView({
    super.key,
    required this.expenses,
    required this.incomeTotal,
    required this.budgetLimit,
    required this.l,
  });

  @override
  State<MonthlyStatsView> createState() => _MonthlyStatsViewState();
}

class _MonthlyStatsViewState extends State<MonthlyStatsView> {
  int _touchedIndex = -1;

  Map<String, double> get _categoryTotals {
    final map = <String, double>{};
    for (final expense in widget.expenses) {
      map[expense.category] = (map[expense.category] ?? 0) + expense.amount;
    }
    return map;
  }

  double get _total =>
      widget.expenses.fold(0.0, (sum, item) => sum + item.amount);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final categoryTotals = _categoryTotals;
    final sortedEntries = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCashflowRow(context, _total, colorScheme),
        const SizedBox(height: 12),
        _buildSummaryRow(context, _total, categoryTotals.length, colorScheme),
        if (sortedEntries.isEmpty) ...[
          const SizedBox(height: 20),
          _buildSectionHeader(context, widget.l.statsCategoryDistribution),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: AppStyles.surfaceCard(context),
            child: Text(
              widget.l.statsNoExpenses,
              style: TextStyle(color: colorScheme.outline),
            ),
          ),
        ] else ...[
          const SizedBox(height: 20),
          _buildSectionHeader(context, widget.l.statsCategoryDistribution),
          const SizedBox(height: 12),
          _buildPieChartCard(context, sortedEntries, _total, colorScheme),
          const SizedBox(height: 20),
          _buildSectionHeader(context, widget.l.statsCategoryDetail),
          const SizedBox(height: 12),
          _buildCategoryList(context, sortedEntries, _total, colorScheme),
        ],
      ],
    );
  }

  Widget _buildCashflowRow(
    BuildContext context,
    double expenseTotal,
    ColorScheme colorScheme,
  ) {
    final net = widget.incomeTotal - expenseTotal;
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            colorScheme,
            icon: Icons.savings_outlined,
            label: widget.l.homeIncome,
            value: formatAmount(widget.incomeTotal),
            color: const Color(0xFF059669),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            colorScheme,
            icon: Icons.payments_outlined,
            label: widget.l.homeSpent,
            value: formatAmount(expenseTotal),
            color: colorScheme.error,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            colorScheme,
            icon: Icons.balance_outlined,
            label: widget.l.homeNet,
            value: formatAmount(net),
            color: net < 0 ? colorScheme.error : const Color(0xFF059669),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    double total,
    int categoryCount,
    ColorScheme colorScheme,
  ) {
    final budgetUsedPercent = widget.budgetLimit <= 0
        ? 0.0
        : (total / widget.budgetLimit * 100).clamp(0.0, 999.0);

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            colorScheme,
            icon: Icons.category_outlined,
            label: widget.l.statsCategoryCount,
            value: '$categoryCount',
            color: const Color(0xFF6366F1),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            colorScheme,
            icon: Icons.percent_outlined,
            label: widget.l.statsBudgetUsage,
            value: '%${budgetUsedPercent.toStringAsFixed(0)}',
            color: budgetUsedPercent > 100
                ? colorScheme.error
                : const Color(0xFF059669),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    ColorScheme colorScheme, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: AppStyles.surfaceCard(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: colorScheme.outline),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildPieChartCard(
    BuildContext context,
    List<MapEntry<String, double>> sortedEntries,
    double total,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppStyles.surfaceCard(context),
      child: Column(
        children: [
          SizedBox(
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (event, response) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              response == null ||
                              response.touchedSection == null) {
                            _touchedIndex = -1;
                            return;
                          }
                          _touchedIndex =
                              response.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    sections: _buildPieSections(sortedEntries, total),
                    sectionsSpace: 3,
                    centerSpaceRadius: 60,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _touchedIndex >= 0 && _touchedIndex < sortedEntries.length
                          ? CategoryHelper.displayName(
                              sortedEntries[_touchedIndex].key,
                              widget.l,
                            )
                          : widget.l.statsTotal,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.outline,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _touchedIndex >= 0 && _touchedIndex < sortedEntries.length
                          ? formatAmount(sortedEntries[_touchedIndex].value)
                          : formatAmount(total),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: sortedEntries.map((entry) {
              final color = CategoryHelper.getColor(entry.key);
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    CategoryHelper.displayName(entry.key, widget.l),
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieSections(
    List<MapEntry<String, double>> entries,
    double total,
  ) {
    return entries.asMap().entries.map((e) {
      final index = e.key;
      final entry = e.value;
      final isTouched = index == _touchedIndex;
      final percentage = (entry.value / total) * 100;
      final color = CategoryHelper.getColor(entry.key);

      return PieChartSectionData(
        value: entry.value,
        title: percentage >= 8 ? '%${percentage.toStringAsFixed(0)}' : '',
        color: color,
        radius: isTouched ? 80 : 68,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
    }).toList();
  }

  Widget _buildCategoryList(
    BuildContext context,
    List<MapEntry<String, double>> sortedEntries,
    double total,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: AppStyles.surfaceCard(context),
      child: Column(
        children: sortedEntries.asMap().entries.map((e) {
          final index = e.key;
          final entry = e.value;
          final color = CategoryHelper.getColor(entry.key);
          final percentage = (entry.value / total) * 100;
          final isLast = index == sortedEntries.length - 1;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        CategoryHelper.getIcon(entry.key),
                        color: color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                CategoryHelper.displayName(entry.key, widget.l),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                formatAmount(entry.value),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: entry.value / total,
                                    backgroundColor: color.withValues(
                                      alpha: 0.12,
                                    ),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      color,
                                    ),
                                    minHeight: 5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '%${percentage.toStringAsFixed(1)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colorScheme.outline,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  indent: 74,
                  endIndent: 20,
                  color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: 0.5,
      ),
    );
  }
}
