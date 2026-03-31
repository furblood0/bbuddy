import 'package:flutter/material.dart';

class CategoryHelper {
  static const List<String> categories = [
    'Yemek',
    'Ulaşım',
    'Eğlence',
    'Market',
    'Fatura',
    'Diğer',
  ];

  static IconData getIcon(String category) {
    switch (category) {
      case 'Yemek':
        return Icons.restaurant_outlined;
      case 'Ulaşım':
        return Icons.directions_bus_outlined;
      case 'Eğlence':
        return Icons.movie_outlined;
      case 'Market':
        return Icons.shopping_basket_outlined;
      case 'Fatura':
        return Icons.receipt_outlined;
      default:
        return Icons.category_outlined;
    }
  }

  static Color getColor(String category) {
    switch (category) {
      case 'Yemek':
        return Colors.orange;
      case 'Ulaşım':
        return Colors.blue;
      case 'Eğlence':
        return Colors.purple;
      case 'Market':
        return Colors.green;
      case 'Fatura':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
