import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum TaskState { pending, finished, overdue }

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database? _db;

  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db!;
    }

    String path = join(await getDatabasesPath(), 'todotask.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE task (id integer PRIMARY key autoincrement, taskName varchar(255), description varchar(255), dueDate varchar(50), taskState varchar(50))',
        );
      },
    );
    return _db!;
  }

  Future<int> createTask(DataBaseSQ task) async {
    Database db = await createDatabase();
    return db.insert('task', task.DataToMap());
  }

  Future<List<Map<String, dynamic>>> allTasks() async {
    Database db = await createDatabase();
    return db.query('task');
  }

  Future<int> delete(int id) async {
    Database db = await createDatabase();
    return db.delete('task', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTaskState(int id, TaskState newState) async {
    Database db = await createDatabase();
    return db.update(
      'task',
      {'taskState': newState.toString()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> checkOverdueTasks() async {
    Database db = await createDatabase();
    final now = DateTime.now();
    final tasks = await db.query('task');

    for (var task in tasks) {
      final dueDate = DateTime.parse(task['dueDate'] as String);
      if (dueDate.isBefore(now) &&
          task['taskState'] != TaskState.finished.toString()) {
        await updateTaskState(task['id'] as int, TaskState.overdue);
      }
    }
  }
}

class DataBaseSQ extends ChangeNotifier {
  String? _taskName;
  String? _description;
  String? _dueDate;
  TaskState? _taskState;
  int? _id;

  DataBaseSQ(Map<String, dynamic> task) {
    _taskName = task['taskName'];
    _description = task['description'];
    _dueDate = task['dueDate'];
    _taskState = task['taskState'] ?? TaskState.pending;
    _id = task['id'];
  }

  DataBaseSQ.fromMap(Map<String, dynamic> task) {
    _taskName = task['taskName'];
    _description = task['description'];
    _dueDate = task['dueDate'];
    _taskState = TaskState.values.firstWhere(
      (e) => e.toString() == task['taskState'],
      orElse: () => TaskState.pending,
    );
    _id = task['id'];
  }

  Map<String, dynamic> DataToMap() {
    Map<String, dynamic> data = {
      'taskName': _taskName,
      'description': _description,
      'dueDate': _dueDate,
      'taskState': _taskState?.toString(),
    };
    if (_id != null) {
      data['id'] = _id;
    }
    return data;
  }

  String get taskName => _taskName ?? '';
  String get description => _description ?? '';
  String get dueDate => _dueDate ?? '';
  TaskState get taskState => _taskState ?? TaskState.pending;
  int? get id => _id;
}
