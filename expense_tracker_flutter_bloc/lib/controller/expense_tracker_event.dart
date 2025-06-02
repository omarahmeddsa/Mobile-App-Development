part of 'expense_tracker_bloc.dart';

sealed class ExpenseTrackerEvent {}

class ExpenseAdd extends ExpenseTrackerEvent {
  final ExpenseModel NewExpensemodel;

  ExpenseAdd(this.NewExpensemodel);
}

class ExpenseRemove extends ExpenseTrackerEvent {
  final String id;
  ExpenseRemove(this.id);
}

class AddCashAmount extends ExpenseTrackerEvent {
  double newCashAmount;
  AddCashAmount({required this.newCashAmount});
}
