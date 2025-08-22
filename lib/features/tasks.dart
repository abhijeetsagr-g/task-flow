import 'package:flutter/material.dart';
import 'package:task_flow/features/db_helper.dart';

class Task {
  int? id;
  String title;
  String description;
  String reminderTime;
  bool isCompleted = false;
  Task(
    this.id,
    this.title,
    this.description,
    this.reminderTime,
    this.isCompleted,
  );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "reminderTime": reminderTime,
      "isCompleted": isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      map['id'] as int?,
      map['title'] as String,
      map['description'] as String,
      map['reminderTime'] as String,
      map['isCompleted'] == 1,
    );
  }
}

class TaskList with ChangeNotifier {
  final DatabaseHelper db = DatabaseHelper();

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> loadTask() async {
    final loadedTasks = await db.getTasks();
    _tasks = loadedTasks;
    notifyListeners();
  }

  void addItems(Task newTask) {
    db.insertTask(newTask);
    loadTask();
  }

  void removeItem(int? index) {
    if (index != null) {
      db.deleteTask(index);
    }

    loadTask();
  }

  void toggleCompleted(Task newtask, bool isCompleted) {
    newtask.isCompleted = !isCompleted;
    db.updateTask(newtask);
    loadTask();
  }

  void changeTitle(int index, String newTitle) {
    _tasks[index].title = newTitle;
    notifyListeners();
  }

  void changeDescription(int index, String newDes) {
    _tasks[index].description = newDes;
    notifyListeners();
  }

  void changeReminder(int index, String newTime) {
    _tasks[index].reminderTime = newTime;
    notifyListeners();
  }
}
