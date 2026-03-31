import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/category_helper.dart';
import '../../providers/expense_provider.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _touchedIndex = -1;

  String _formatAmount(double amount) {
    final str = amount.toStringAsFixed(2);
    final parts = str.split('.');
    String intPart = parts[0];
    final decPart = parts[1];
    final buffer = StringBuffer();
    for (int i = 0; i < intPart.length; i++) {
      if (i > 0 && (intPart.length - i) % 3 == 0) buffer.write('.');
      buffer.write(intPart[i]);
    }
    return '${buffer.toString()},$decPart ₺';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final categoryTotals = provider.categoryTotals;
    final total = provider.totalExpenses;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  const Icon(Icons.pie_chart, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            const Text(
              'İstatistikler',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
      ),
      body: provider.expenses.isEmpty
          ? _buildEmptyState(colorScheme)
          : _buildContent(
              context, provider, categoryTotals, total, colorScheme),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.pie_chart_outline,
                size: 36, color: colorScheme.outline),
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz gösterilecek veri yok',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface),
          ),
          const SizedBox(height: 6),
          Text(
            'Harcama ekledikçe grafikler burada görünür',
            style: TextStyle(fontSize: 13, color: colorScheme.outline),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    dynamic provider,
    Map<String, double> categoryTotals,
    double total,
    ColorScheme colorScheme,
  ) {
    final sortedEntries = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow(provider, total, colorScheme),
          const SizedBox(height: 20),
          _buildSectionHeader(context, 'Kategori Dağılımı'),
          const SizedBox(height: 12),
          _buildPieChartCard(sortedEntries, total, colorScheme),
          const SizedBox(height: 20),
          _buildSectionHeader(context, 'Kategori Detayı'),
          const SizedBox(height: 12),
          _buildCategoryList(sortedEntries, total, colorScheme),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(dynamic provider, double total, ColorScheme colorScheme) {
    final budgetUsedPercent =
        (total / provider.budgetLimit * 100).clamp(0.0, 999.0);

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            colorScheme,
            icon: Icons.payments_outlined,
            label: 'Toplam Harcama',
            value: _formatAmount(total),
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            colorScheme,
            icon: Icons.category_outlined,
            label: 'Kategori Sayısı',
            value: '${provider.categoryTotals.length}',
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            colorScheme,
            icon: Icons.percent_outlined,
            label: 'Bütçe Kullanımı',
            value: '%${budgetUsedPercent.toStringAsFixed(0)}',
            color: budgetUsedPercent > 100 ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    ColorScheme colorScheme, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
    List<MapEntry<String, double>> sortedEntries,
    double total,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
                          _touchedIndex = response
                              .touchedSection!.touchedSectionIndex;
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
                      _touchedIndex >= 0 &&
                              _touchedIndex < sortedEntries.length
                          ? sortedEntries[_touchedIndex].key
                          : 'Toplam',
                      style: TextStyle(
                          fontSize: 12, color: colorScheme.outline),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _touchedIndex >= 0 &&
                              _touchedIndex < sortedEntries.length
                          ? _formatAmount(
                              sortedEntries[_touchedIndex].value)
                          : _formatAmount(total),
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
                  Text(entry.key,
                      style: TextStyle(
                          fontSize: 12, color: colorScheme.onSurface)),
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
    List<MapEntry<String, double>> sortedEntries,
    double total,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
                    horizontal: 20, vertical: 14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    entry.key,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    _formatAmount(entry.value),
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
                                      borderRadius:
                                          BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: entry.value / total,
                                        backgroundColor: color
                                            .withOpacity(0.12),
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                color),
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
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  indent: 74,
                  endIndent: 20,
                  color:
                      colorScheme.outlineVariant.withOpacity(0.4),
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
