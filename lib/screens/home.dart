import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/features/tasks.dart';

import 'package:task_flow/widgets/note_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

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

            return NoteCard(task: task);
          },
        );
      },
    );
  }
}
