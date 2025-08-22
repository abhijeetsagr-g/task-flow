import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/features/tasks.dart';

class NoteDetailPage extends StatefulWidget {
  final Task task;

  const NoteDetailPage({super.key, required this.task});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late final _task = widget.task;

  Color noteColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: noteColor,
      appBar: AppBar(
        backgroundColor: noteColor,
        elevation: 0,

        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined),
            onPressed: () {
              final taskList = Provider.of<TaskList>(context, listen: false);
              taskList.removeItem(_task.id);
              Navigator.pop(context);
            },
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.check_circle_outline)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _task.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(_task.description),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  _task.reminderTime,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_active_outlined,
                    size: 16,
                    color: Colors.cyan,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit_outlined),
      ),
    );
  }
}
