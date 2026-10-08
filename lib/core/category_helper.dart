import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/transaction_kind.dart';

class CategoryHelper {
  static const String food = 'food';
  static const String grocery = 'grocery';
  static const String transport = 'transport';
  static const String education = 'education';
  static const String health = 'health';
  static const String subscription = 'subscription';
  static const String housing = 'housing';
  static const String entertainment = 'entertainment';
  static const String bills = 'bills';
  static const String other = 'other';
  static const String allowance = 'allowance';
  static const String scholarship = 'scholarship';
  static const String job = 'job';
  static const String family = 'family';

  static const List<String> categories = [
    food,
    grocery,
    transport,
    education,
    health,
    subscription,
    housing,
    entertainment,
    bills,
    other,
  ];

  static const List<String> incomeCategories = [
    allowance,
    scholarship,
    job,
    family,
    other,
  ];

  static const String defaultCategory = food;

  static List<String> categoriesFor(String kind) =>
      kind == TransactionKind.income ? incomeCategories : categories;

  static String defaultFor(String kind) =>
      kind == TransactionKind.income ? allowance : defaultCategory;

  static String normalize(String key, {String kind = TransactionKind.expense}) {
    return categoriesFor(kind).contains(key) ? key : other;
  }

  static String resolveTitle(
    String input,
    String category,
    AppLocalizations l, {
    String kind = TransactionKind.expense,
  }) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return displayName(category, l, kind: kind);
    }
    return trimmed;
  }

  static bool isDefaultTitle(
    String title,
    String category,
    AppLocalizations l, {
    String kind = TransactionKind.expense,
  }) {
    return title.trim() == displayName(category, l, kind: kind);
  }

  static String displayName(
    String key,
    AppLocalizations l, {
    String kind = TransactionKind.expense,
  }) {
    if (kind == TransactionKind.income) {
      switch (normalize(key, kind: kind)) {
        case allowance:
          return l.categoryAllowance;
        case scholarship:
          return l.categoryScholarship;
        case job:
          return l.categoryJob;
        case family:
          return l.categoryFamily;
        default:
          return l.categoryOther;
      }
    }
    switch (normalize(key)) {
      case food:
        return l.categoryFood;
      case grocery:
        return l.categoryGrocery;
      case transport:
        return l.categoryTransport;
      case education:
        return l.categoryEducation;
      case health:
        return l.categoryHealth;
      case subscription:
        return l.categorySubscription;
      case housing:
        return l.categoryHousing;
      case entertainment:
        return l.categoryEntertainment;
      case bills:
        return l.categoryBills;
      default:
        return l.categoryOther;
    }
  }

  static IconData getIcon(
    String category, {
    String kind = TransactionKind.expense,
  }) {
    if (kind == TransactionKind.income) {
      switch (normalize(category, kind: kind)) {
        case allowance:
          return Icons.savings_outlined;
        case scholarship:
          return Icons.menu_book_outlined;
        case job:
          return Icons.work_outline;
        case family:
          return Icons.family_restroom_outlined;
        default:
          return Icons.more_horiz_rounded;
      }
    }
    switch (normalize(category)) {
      case food:
        return Icons.restaurant_outlined;
      case grocery:
        return Icons.shopping_basket_outlined;
      case transport:
        return Icons.directions_bus_outlined;
      case education:
        return Icons.school_outlined;
      case health:
        return Icons.medical_services_outlined;
      case subscription:
        return Icons.subscriptions_outlined;
      case housing:
        return Icons.home_outlined;
      case entertainment:
        return Icons.movie_outlined;
      case bills:
        return Icons.receipt_long_outlined;
      default:
        return Icons.more_horiz_rounded;
    }
  }

  static Color getColor(
    String category, {
    String kind = TransactionKind.expense,
  }) {
    if (kind == TransactionKind.income) {
      switch (normalize(category, kind: kind)) {
        case allowance:
          return const Color(0xFF0D9488);
        case scholarship:
          return const Color(0xFF4F46E5);
        case job:
          return const Color(0xFF059669);
        case family:
          return const Color(0xFFD97706);
        default:
          return const Color(0xFF64748B);
      }
    }
    switch (normalize(category)) {
      case food:
        return const Color(0xFFF59E0B);
      case grocery:
        return const Color(0xFF10B981);
      case transport:
        return const Color(0xFF3B82F6);
      case education:
        return const Color(0xFF6366F1);
      case health:
        return const Color(0xFFEC4899);
      case subscription:
        return const Color(0xFF8B5CF6);
      case housing:
        return const Color(0xFF78716C);
      case entertainment:
        return const Color(0xFFA855F7);
      case bills:
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF64748B);
    }
  }
}
