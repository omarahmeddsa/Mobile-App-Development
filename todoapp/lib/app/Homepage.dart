import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app/SignIn.dart';
import 'package:todoapp/app/TaskForm.dart';
import 'package:todoapp/provider/Auth_provider.dart';
import 'package:todoapp/provider/DataBase.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DbHelper _dbHelper = DbHelper();
  List<DataBaseSQ> _tasks = [];
  bool _isLoading = true;
  TaskState _selectedFilter = TaskState.pending;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _dbHelper.checkOverdueTasks(); // Check for overdue tasks
      final tasks = await _dbHelper.allTasks();
      setState(() {
        _tasks = tasks.map((task) => DataBaseSQ.fromMap(task)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading tasks: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteTask(int id) async {
    try {
      await _dbHelper.delete(id);
      await _loadTasks();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting task: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _updateTaskState(int id, TaskState newState) async {
    try {
      await _dbHelper.updateTaskState(id, newState);
      await _loadTasks();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task status updated'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating task: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMMM d, yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  Color _getTaskStateColor(TaskState state) {
    switch (state) {
      case TaskState.pending:
        return Colors.orange;
      case TaskState.finished:
        return Colors.green;
      case TaskState.overdue:
        return Colors.red;
    }
  }

  IconData _getTaskStateIcon(TaskState state) {
    switch (state) {
      case TaskState.pending:
        return Icons.pending_actions;
      case TaskState.finished:
        return Icons.check_circle;
      case TaskState.overdue:
        return Icons.warning;
    }
  }

  List<DataBaseSQ> get _filteredTasks {
    return _tasks.where((task) => task.taskState == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            onPressed: () {
              authProvider.SignOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Signin()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    TaskState.values.map((state) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: FilterChip(
                          selected: _selectedFilter == state,
                          label: Text(state.toString().split('.').last),
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = state;
                            });
                          },
                          backgroundColor: _getTaskStateColor(
                            state,
                          ).withOpacity(0.1),
                          selectedColor: _getTaskStateColor(
                            state,
                          ).withOpacity(0.3),
                          checkmarkColor: _getTaskStateColor(state),
                          labelStyle: TextStyle(
                            color:
                                _selectedFilter == state
                                    ? _getTaskStateColor(state)
                                    : Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          Expanded(
            child:
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _filteredTasks.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.task_alt, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No ${_selectedFilter.toString().split('.').last} tasks',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Tap + to add a new task',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : RefreshIndicator(
                      onRefresh: _loadTasks,
                      child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: _filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = _filteredTasks[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text(
                                task.taskName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text(task.description),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        _formatDate(task.dueDate),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(width: 16),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getTaskStateColor(
                                            task.taskState,
                                          ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              _getTaskStateIcon(task.taskState),
                                              size: 14,
                                              color: _getTaskStateColor(
                                                task.taskState,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              task.taskState
                                                  .toString()
                                                  .split('.')
                                                  .last,
                                              style: TextStyle(
                                                color: _getTaskStateColor(
                                                  task.taskState,
                                                ),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  PopupMenuButton<TaskState>(
                                    icon: Icon(Icons.more_vert),
                                    onSelected: (TaskState newState) {
                                      if (task.id != null) {
                                        _updateTaskState(task.id!, newState);
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return TaskState.values.map((
                                        TaskState state,
                                      ) {
                                        return PopupMenuItem<TaskState>(
                                          value: state,
                                          child: Row(
                                            children: [
                                              Icon(
                                                _getTaskStateIcon(state),
                                                color: _getTaskStateColor(
                                                  state,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                state
                                                    .toString()
                                                    .split('.')
                                                    .last,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      if (task.id != null) {
                                        _deleteTask(task.id!);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskForm()),
          );
          _loadTasks();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
