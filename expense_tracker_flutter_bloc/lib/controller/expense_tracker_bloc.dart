import 'package:expense_tracker_flutter_bloc/model/ExpenseModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'expense_tracker_state.dart';

part 'expense_tracker_event.dart';

class ExpenseTrackerBloc
    extends Bloc<ExpenseTrackerEvent, ExpenseTrackerState> {
  ExpenseTrackerBloc() : super(const ExpenseTrackerUpdate(oldExpenseList: [])) {
    on<ExpenseAdd>((event, emit) {
      try {
        final expenseModel = ExpenseModel(
          id: const Uuid().v4(),
          title: event.NewExpensemodel.title,
          amount: event.NewExpensemodel.amount,
          category: event.NewExpensemodel.category,
          date: event.NewExpensemodel.date,
        );

        if (state is ExpenseTrackerUpdate) {
          final currentState = state as ExpenseTrackerUpdate;
          emit(
            ExpenseTrackerUpdate(
              oldExpenseList: [...currentState.oldExpenseList, expenseModel],
            ),
          );
        }
      } catch (e) {
        emit(ExpenseTrackerErrMsg(errMsg: 'Failed to add expense: $e'));
      }
    });

    on<ExpenseRemove>((event, emit) {
      if (state is ExpenseTrackerUpdate) {
        final currentState = state as ExpenseTrackerUpdate;
        try {
          final updatedList =
              currentState.oldExpenseList
                  .where((expense) => expense.id != event.id)
                  .toList();

          emit(ExpenseTrackerUpdate(oldExpenseList: updatedList));
        } catch (e) {
          emit(ExpenseTrackerErrMsg(errMsg: e.toString()));
        }
      }
    });
  }
}
