import 'package:flutter/material.dart';

import 'app_theme.dart';

abstract final class AppStyles {
  static const radiusSm = 12.0;
  static const radiusMd = 16.0;
  static const radiusLg = 20.0;
  static const radiusXl = 28.0;

  static const pagePadding = 16.0;

  static BoxDecoration surfaceCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BoxDecoration(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(radiusLg),
      border: Border.all(
        color: colorScheme.outlineVariant.withValues(
          alpha: isDark ? 0.35 : 0.55,
        ),
      ),
      boxShadow: isDark
          ? null
          : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
    );
  }

  static BoxDecoration budgetCard({
    required bool isOverBudget,
    required bool isDark,
  }) {
    if (isOverBudget) {
      return BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF991B1B), const Color(0xFFDC2626)]
              : [const Color(0xFFB91C1C), const Color(0xFFEF4444)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusXl),
      );
    }

    return BoxDecoration(
      gradient: LinearGradient(
        colors: isDark
            ? [const Color(0xFF115E59), AppTheme.brandPrimary]
            : [AppTheme.brandPrimaryDark, AppTheme.brandPrimaryLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(radiusXl),
      boxShadow: [
        BoxShadow(
          color: AppTheme.brandPrimaryDark.withValues(
            alpha: isDark ? 0.25 : 0.32,
          ),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  static Widget sheetHandle(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
