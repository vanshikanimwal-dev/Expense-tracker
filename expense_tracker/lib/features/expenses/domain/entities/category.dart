import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

enum ExpenseCategory {
  food,
  transport,
  shopping,
  entertainment,
  health,
  other,
}

extension ExpenseCategoryX on ExpenseCategory {
  String get displayName {
    switch (this) {
      case ExpenseCategory.food:
        return 'Food';
      case ExpenseCategory.transport:
        return 'Transport';
      case ExpenseCategory.shopping:
        return 'Shopping';
      case ExpenseCategory.entertainment:
        return 'Entertainment';
      case ExpenseCategory.health:
        return 'Health';
      case ExpenseCategory.other:
        return 'Other';
    }
  }

  Color get color {
    switch (this) {
      case ExpenseCategory.food:
        return AppColors.primaryTeal;
      case ExpenseCategory.transport:
        return AppColors.expenseRed;
      case ExpenseCategory.shopping:
        return const Color(0xFFFFB74D);
      case ExpenseCategory.entertainment:
        return const Color(0xFF9575CD);
      case ExpenseCategory.health:
        return const Color(0xFF4FC3F7);
      case ExpenseCategory.other:
        return Colors.grey;
    }
  }
}
