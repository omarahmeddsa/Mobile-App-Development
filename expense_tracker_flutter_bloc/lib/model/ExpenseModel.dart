import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ExpenseModel extends Equatable {
  final String id;
  final String title;
  final double amount;
  final String category;

  const ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, amount, category];

  factory ExpenseModel.fromJson(Map<String, dynamic> data) {
    return ExpenseModel(
      id: data['id'] ?? const Uuid().v4(),
      title: data['title'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      category: data['category'] ?? 'Other',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'amount': amount, 'category': category};
  }
}
