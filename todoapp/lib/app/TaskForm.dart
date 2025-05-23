import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/provider/DataBase.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  bool _isSubmitting = false;

  @override
  void dispose() {
    _dateController.dispose();
    _taskNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        DbHelper helper = DbHelper();
        final taskData = {
          'taskName': _taskNameController.text,
          'description': _descriptionController.text,
          'dueDate': _dateController.text,
          'taskState': TaskState.pending,
        };

        await helper.createTask(DataBaseSQ(taskData));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task created successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          // Clear form
          _formKey.currentState!.reset();
          _dateController.clear();
          _taskNameController.clear();
          _descriptionController.clear();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error creating task: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Task'), elevation: 0),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 30, right: 30),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _taskNameController,
                      decoration: InputDecoration(
                        label: Text('Task name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a task name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        label: Text('Task description'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        label: Text('Due Date'),
                        prefixIcon: Icon(Icons.calendar_today),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a due date';
                        }
                        return null;
                      },
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Theme.of(context).primaryColor,
                                  onPrimary: Colors.white,
                                  surface: Colors.white,
                                  onSurface: Colors.black,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (picked != null) {
                          setState(() {
                            _dateController.text = _dateFormat.format(picked);
                          });
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child:
                          _isSubmitting
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                'Create Task',
                                style: TextStyle(fontSize: 18),
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
