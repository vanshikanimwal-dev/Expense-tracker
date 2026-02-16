import 'package:equatable/equatable.dart';
import 'category.dart';

class Expense extends Equatable {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;
  final String userId; // To ensure users only see their own data

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.userId,
  });

  // Convert Firestore Document to Expense Object
  factory Expense.fromMap(Map<String, dynamic> map, String id) {
    return Expense(
      id: id,
      title: map['title'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      date: DateTime.parse(map['date']),
      category: ExpenseCategory.values.firstWhere(
            (e) => e.toString() == map['category'],
        orElse: () => ExpenseCategory.other,
      ),
      userId: map['userId'] ?? '',
    );
  }

  // Convert Expense Object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.toString(),
      'userId': userId,
    };
  }

  @override
  List<Object?> get props => [id, title, amount, date, category, userId];
}