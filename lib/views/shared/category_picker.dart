import 'package:flutter/material.dart';

import '../../core/app_styles.dart';
import '../../core/category_helper.dart';
import '../../l10n/app_localizations.dart';
import '../../models/transaction_kind.dart';

class CategoryPicker extends StatelessWidget {
  final String selectedCategory;
  final String kind;
  final ValueChanged<String> onCategoryChanged;

  const CategoryPicker({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    this.kind = TransactionKind.expense,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: CategoryHelper.categoriesFor(kind).map((category) {
        final isSelected = selectedCategory == category;
        final color = CategoryHelper.getColor(category, kind: kind);
        return GestureDetector(
          onTap: () => onCategoryChanged(category),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? color.withValues(alpha: 0.15)
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppStyles.radiusSm),
              border: Border.all(
                color: isSelected ? color : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CategoryHelper.getIcon(category, kind: kind),
                  size: 16,
                  color: isSelected ? color : colorScheme.outline,
                ),
                const SizedBox(width: 6),
                Text(
                  CategoryHelper.displayName(category, l, kind: kind),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: isSelected ? color : colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
