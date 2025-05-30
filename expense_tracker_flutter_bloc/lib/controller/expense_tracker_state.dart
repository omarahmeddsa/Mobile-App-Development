import 'package:equatable/equatable.dart';
import 'package:expense_tracker_flutter_bloc/model/ExpenseModel.dart';

sealed class ExpenseTrackerState extends Equatable {
  const ExpenseTrackerState();
}

class ExpenseTrackerUpdate extends ExpenseTrackerState {
  final List<ExpenseModel> oldExpenseList;

  const ExpenseTrackerUpdate({required this.oldExpenseList});

  @override
  List<Object> get props => [oldExpenseList];
}

class ExpenseTrackerErrMsg extends ExpenseTrackerState {
  final String errMsg;

  const ExpenseTrackerErrMsg({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}
