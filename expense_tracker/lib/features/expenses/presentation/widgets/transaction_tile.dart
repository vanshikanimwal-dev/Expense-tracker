import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/expense.dart';

class TransactionTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;

  const TransactionTile({super.key, required this.expense, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Determine color and sign based on category logic
    // (Assuming all your current entries are expenses for now)
    final isIncome = expense.amount > 0 && expense.title.toLowerCase().contains('salary');

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            // Icon Container - Matches the reference square-round style
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _getCategoryIcon(expense.category.name),
                color: AppColors.textGrey,
              ),
            ),
            const SizedBox(width: 16),
            // Title and Category
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
                  ),
                  Text(
                    expense.category.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            // Amount - Matches the bold color-coded style
            Text(
              '${isIncome ? '+' : '-'}${expense.amount.formatCurrency}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isIncome ? AppColors.incomeGreen : AppColors.expenseRed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food': return Icons.restaurant;
      case 'transport': return Icons.directions_car;
      case 'shopping': return Icons.shopping_bag;
      default: return Icons.receipt_long;
    }
  }
}