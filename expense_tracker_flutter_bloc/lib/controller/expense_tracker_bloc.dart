import 'package:expense_tracker_flutter_bloc/model/ExpenseModel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:uuid/uuid.dart';

import 'expense_tracker_state.dart';

part 'expense_tracker_event.dart';

class ExpenseTrackerBloc
    extends HydratedBloc<ExpenseTrackerEvent, ExpenseTrackerState> {
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

  @override
  ExpenseTrackerState? fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic> expensesJson = json['expenses'] as List<dynamic>;
      final expenses =
          expensesJson
              .map((e) => ExpenseModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return ExpenseTrackerUpdate(oldExpenseList: expenses);
    } catch (e) {
      return const ExpenseTrackerUpdate(oldExpenseList: []);
    }
  }

  @override
  Map<String, dynamic>? toJson(ExpenseTrackerState state) {
    if (state is ExpenseTrackerUpdate) {
      return {'expenses': state.oldExpenseList.map((e) => e.toJson()).toList()};
    }
    return null;
  }
}
