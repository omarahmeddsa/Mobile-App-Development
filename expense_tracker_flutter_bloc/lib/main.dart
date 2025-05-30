import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/expense_tracker_bloc.dart';
import 'controller/expense_tracker_state.dart';
import 'model/ExpenseModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseTrackerBloc(),
      child: MaterialApp(
        title: 'Expense Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const ExpenseTrackerScreen(),
      ),
    );
  }
}

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({super.key});

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'Other';

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _addExpense() {
    if (_formKey.currentState?.validate() ?? false) {
      final expense = ExpenseModel(
        id: '',
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        category: _selectedCategory,
      );
      context.read<ExpenseTrackerBloc>().add(ExpenseAdd(expense));
      _titleController.clear();
      _amountController.clear();
      setState(() {
        _selectedCategory = 'Other';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Expense')),
      body: Column(
        children: [
          // Simple form to add expense
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: const [
                      DropdownMenuItem(value: 'Food', child: Text('Food')),
                      DropdownMenuItem(
                        value: 'Transport',
                        child: Text('Transport'),
                      ),
                      DropdownMenuItem(
                        value: 'Shopping',
                        child: Text('Shopping'),
                      ),
                      DropdownMenuItem(value: 'Other', child: Text('Other')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addExpense,
                    child: const Text('Add Expense'),
                  ),
                ],
              ),
            ),
          ),
          // List of expenses
          Expanded(
            child: BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
              builder: (context, state) {
                if (state is ExpenseTrackerUpdate) {
                  if (state.oldExpenseList.isEmpty) {
                    return const Center(
                      child: Text('No expenses yet. Add some!'),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.oldExpenseList.length,
                    itemBuilder: (context, index) {
                      final expense = state.oldExpenseList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(expense.title),
                          subtitle: Text('Category: ${expense.category}'),
                          trailing: Text(
                            '\$${expense.amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('Something went wrong'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
