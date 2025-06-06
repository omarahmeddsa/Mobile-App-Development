import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/controller/expense_tracker_bloc.dart';
import '/model/ExpenseModel.dart';

class AddExpenseWidget extends StatelessWidget {
  const AddExpenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExpenseForm();
  }
}

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.other;
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _addExpense() {
    if (_formKey.currentState?.validate() ?? false) {
      final expense = ExpenseModel(
        id: '',
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        category: _selectedCategory,
        date: _dateController.text,
      );
      context.read<ExpenseTrackerBloc>().add(ExpenseAdd(expense));
      _titleController.clear();
      _amountController.clear();
      _dateController.clear();
      setState(() {
        _selectedCategory = Category.other;
      });
    }
  }

  void _chooseDate() async {
    final DateTime? datepicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2030),
    );

    if (datepicked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(datepicked);
      _dateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 80, right: 20, left: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(75, 218, 249, 1),
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(75, 218, 249, 1),
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
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
                  const SizedBox(height: 16),
                  DropdownButtonFormField<Category>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(75, 218, 249, 1),
                        ),
                      ),
                    ),
                    dropdownColor: Color.fromRGBO(27, 35, 57, 1),
                    style: const TextStyle(color: Colors.white),
                    items: const [
                      DropdownMenuItem(
                        value: Category.food,
                        child: Text('Food'),
                      ),
                      DropdownMenuItem(
                        value: Category.transport,
                        child: Text('Transport'),
                      ),
                      DropdownMenuItem(
                        value: Category.shopping,
                        child: Text('Shopping'),
                      ),
                      DropdownMenuItem(
                        value: Category.other,
                        child: Text('Other'),
                      ),
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
                  TextFormField(
                    onTap: _chooseDate,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter a date';
                      } else {
                        return null;
                      }
                    },
                    controller: _dateController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(27, 35, 57, 1),
                      hintText: 'Select date',
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: Icon(
                        Icons.date_range_rounded,
                        color: Colors.white,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(75, 218, 249, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addExpense,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(75, 218, 249, 1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Add Expense'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
