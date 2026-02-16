import 'package:flutter/material.dart';
import '../../features/expenses/domain/entities/category.dart';

extension CategoryColorExtension on ExpenseCategory {
  IconData _getIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return Icons.restaurant_rounded;
      case ExpenseCategory.transport:
        return Icons.directions_car_rounded;
      case ExpenseCategory.shopping:
        return Icons.shopping_bag_rounded;
      case ExpenseCategory.entertainment:
        return Icons.movie_rounded;
      case ExpenseCategory.health:
        return Icons.health_and_safety_rounded;
      case ExpenseCategory.other:
        return Icons.receipt_long_rounded;
    }
  }
}
