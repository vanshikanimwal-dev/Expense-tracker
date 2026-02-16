import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';

class FirestoreExpenseRepository implements ExpenseRepository {
  final FirebaseFirestore _firestore;

  FirestoreExpenseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Collection reference
  CollectionReference<Map<String, dynamic>> get _expensesCollection =>
      _firestore.collection('expenses');

  /// Stream user expenses ordered by newest first
  @override
  Stream<List<Expense>> getExpenses(String userId) {
    return _expensesCollection
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) {
      return snapshot.docs.map(_mapDocToExpense).toList();
    });
  }

  /// Add new expense
  @override
  Future<void> addExpense(Expense expense) async {
    await _expensesCollection.add(expense.toMap());
  }

  /// Update existing expense
  @override
  Future<void> updateExpense(Expense expense) async {
    await _expensesCollection.doc(expense.id).update(expense.toMap());
  }

  /// Delete expense
  @override
  Future<void> deleteExpense(String expenseId) async {
    await _expensesCollection.doc(expenseId).delete();
  }

  /// Safe Firestore → Expense mapper
  Expense _mapDocToExpense(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    return Expense(
      id: doc.id,
      title: data['title'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      date: _parseDate(data['date']),
      userId: data['userId'] ?? '',

      /// Safe enum decoding
      category: _parseCategory(data['category']),
    );
  }

  /// Handles Timestamp / Date / null safely
  DateTime _parseDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return DateTime.now();
  }

  /// Robust enum parsing from Firestore string
  ExpenseCategory _parseCategory(dynamic value) {
    if (value == null) return ExpenseCategory.other;

    return ExpenseCategory.values.firstWhere(
          (e) => e.name == value.toString(),
      orElse: () => ExpenseCategory.other,
    );
  }
}
