import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum Category { food, transport, shopping, other }

class ExpenseModel extends Equatable {
  final String id;
  final String title;
  final double amount;
  final Category category;
  final String date;
  const ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, amount, category];

  factory ExpenseModel.fromJson(Map<String, dynamic> data) {
    Category categoryFromString(String str) {
      switch (str.toLowerCase()) {
        case 'food':
          return Category.food;
        case 'transport':
          return Category.transport;
        case 'shopping':
          return Category.shopping;
        default:
          return Category.other;
      }
    }

    return ExpenseModel(
      id: data['id'] ?? const Uuid().v4(),
      title: data['title'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      category: categoryFromString(data['category']?.toString() ?? 'other'),
      date: data['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.toString().split('.').last,
      'date': date,
    };
  }
}
