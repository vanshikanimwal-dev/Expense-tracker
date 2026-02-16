import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/expense.dart';
import '../providers/expense_providers.dart';

class AddExpenseSheet extends ConsumerStatefulWidget {
  final Expense? expenseToEdit;
  const AddExpenseSheet({super.key, this.expenseToEdit});

  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  ExpenseCategory _selectedCategory = ExpenseCategory.food;

  @override
  void initState() {
    super.initState();
    if (widget.expenseToEdit != null) {
      _titleController.text = widget.expenseToEdit!.title;
      _amountController.text = widget.expenseToEdit!.amount.abs().toString();
      _selectedCategory = widget.expenseToEdit!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: EdgeInsets.fromLTRB(
          24, 12, 24,
          MediaQuery.of(context).viewInsets.bottom + 24
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar at the top
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2)
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
              widget.expenseToEdit == null ? 'Add Transaction' : 'Edit Transaction',
              style: Theme.of(context).textTheme.titleLarge
          ),
          const SizedBox(height: 24),

          // Amount Input with Teal accents
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTeal
            ),
            decoration: const InputDecoration(
              prefixText: '₹ ',
              hintText: '0.00',
              border: InputBorder.none,
            ),
          ),

          const Divider(),

          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
                labelText: 'Transaction Note',
                labelStyle: TextStyle(color: AppColors.textGrey),
                border: InputBorder.none,
                hintText: 'e.g., Monthly Salary or Grocery'
            ),
          ),

          const SizedBox(height: 20),
          Text(
              'Select Category',
              style: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 12),

          // Category horizontal chip selector
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ExpenseCategory.values.map((cat) {
                final isSelected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryTeal : AppColors.background,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        cat.displayName.toUpperCase(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 32),

          // Primary Action Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryTeal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text(
                  'Save Transaction',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    // Implement your existing Repository save logic here
    Navigator.pop(context);
  }
}