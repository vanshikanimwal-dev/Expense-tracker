import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/firestore_expense_repository.dart';
import '../../domain/entities/expense.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/expense_repository.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

/// Repository Provider
final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return FirestoreExpenseRepository();
});

/// Stream of current user's expenses
final expensesStreamProvider =
StreamProvider.autoDispose<List<Expense>>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return authState.when(
    data: (user) {
      if (user == null) return Stream.value([]);

      final repo = ref.watch(expenseRepositoryProvider);
      return repo.getExpenses(user.id);
    },
    loading: () => Stream.value([]),
    error: (_, __) => Stream.value([]),
  );
});

/// Summary Model (Dart record)
typedef ExpenseSummary = ({
double total,
Map<ExpenseCategory, double> categoryMap,
});

/// Summary Provider
final expenseSummaryProvider =
Provider.autoDispose<ExpenseSummary>((ref) {
  final expensesAsync = ref.watch(expensesStreamProvider);

  return expensesAsync.when(
    data: (expenses) {
      double total = 0;
      final Map<ExpenseCategory, double> categoryMap = {};

      for (final e in expenses) {
        total += e.amount;
        categoryMap[e.category] =
            (categoryMap[e.category] ?? 0) + e.amount;
      }

      return (total: total, categoryMap: categoryMap);
    },
    loading: () =>
    (total: 0.0, categoryMap: <ExpenseCategory, double>{}),
    error: (_, __) =>
    (total: 0.0, categoryMap: <ExpenseCategory, double>{}),
  );
});
