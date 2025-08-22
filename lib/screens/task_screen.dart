import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/features/tasks.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskList>(
      builder: (context, taskList, child) {
        if (taskList.tasks.isEmpty) {
          return Center(child: Text("Add Some tasks"));
        }
        return ListView.builder(
          itemCount: taskList.tasks.length,
          itemBuilder: (context, index) {
            final task = taskList.tasks[index];
            return Card(
              color: task.isCompleted ? Colors.lightGreen : Colors.redAccent,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(12),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            taskList.toggleCompleted(task, task.isCompleted);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
