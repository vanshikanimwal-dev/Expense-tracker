import '../entities/expense.dart';

abstract class ExpenseRepository {
  // Get a real-time stream of expenses for a specific user
  Stream<List<Expense>> getExpenses(String userId);

  Future<void> addExpense(Expense expense);
  Future<void> updateExpense(Expense expense);
  Future<void> deleteExpense(String expenseId);
}