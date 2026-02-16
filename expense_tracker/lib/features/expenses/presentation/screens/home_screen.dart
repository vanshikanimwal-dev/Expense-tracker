import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Core
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';

// Auth / Data
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/expense_providers.dart';

// Domain
import '../../domain/entities/expense.dart';
import '../../domain/entities/category.dart';

// Screens
import 'analytics_screen.dart';

// Widgets
import '../widgets/home_header.dart';
import '../widgets/main_balance_card.dart';
import '../widgets/monthly_bar_chart.dart';
import '../widgets/add_expense_sheet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expensesStreamProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      body: SafeArea(
        child: expensesAsync.when(
          data: (expenses) {
            final totalIncome = expenses
                .where((e) => e.amount > 0)
                .fold<double>(0, (sum, e) => sum + e.amount);

            final totalExpense = expenses
                .where((e) => e.amount < 0)
                .fold<double>(0, (sum, e) => sum + e.amount.abs());

            final totalBalance = totalIncome - totalExpense;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const HomeHeader(userName: 'vanshika nimwal'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: MainBalanceCard(
                          totalBalance: totalBalance,
                          income: totalIncome,
                          expense: totalExpense,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: MonthlyBarChart(),
                      ),
                    ],
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Transactions',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AnalyticsScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: AppColors.primaryTeal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                expenses.isEmpty
                    ? const SliverFillRemaining(
                  child: Center(child: Text("No transactions yet.")),
                )
                    : SliverPadding(
                  padding: const EdgeInsets.only(bottom: 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final Expense expense = expenses[index];
                        final bool isIncome = expense.amount >= 0;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 6),
                          child: Dismissible(
                            key: Key(expense.id),
                            direction: DismissDirection.endToStart,
                            background: _buildDeleteBackground(),
                            onDismissed: (_) {
                              ref
                                  .read(expenseRepositoryProvider)
                                  .deleteExpense(expense.id);
                            },
                            child: _buildTransactionCard(
                              context,
                              expense,
                              isIncome,
                            ),
                          ),
                        );
                      },
                      childCount: expenses.length,
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () =>
          const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }

  Widget _buildTransactionCard(
      BuildContext context, Expense expense, bool isIncome) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black.withOpacity(0.02)
                : Colors.transparent,
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            _getIcon(expense.category),
            color: AppColors.textGrey,
          ),
        ),
        title: Text(
          expense.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          '${expense.category.displayName} • ${expense.date.formatDate}',
          style:
          const TextStyle(color: AppColors.textGrey, fontSize: 13),
        ),
        trailing: Text(
          '${isIncome ? '+' : '-'}${expense.amount.abs().formatCurrency}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color:
            isIncome ? AppColors.incomeGreen : AppColors.expenseRed,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.expenseRed.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(Icons.delete_outline, color: Colors.white),
    );
  }

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

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddExpenseSheet(),
    );
  }
}
