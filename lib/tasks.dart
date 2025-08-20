import 'package:flutter/material.dart';

class Task {
  int? id;
  String title;
  String description;
  String reminderTime;
  bool isCompleted = false;
  Task(this.title, this.description, this.reminderTime, this.isCompleted);
}

class TaskList with ChangeNotifier {
  final List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  void addItems(Task newTask) {
    _tasks.add(newTask);
    notifyListeners();
  }

  void removeItem(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void toggleCompleted(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
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
