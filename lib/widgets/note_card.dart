import 'package:flutter/material.dart';
import 'package:task_flow/tasks.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: task.isCompleted ? Colors.greenAccent : Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Notification Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.cyan,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Description
            Text(task.description, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            // Reminder Time
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.cyan, size: 20),
                const SizedBox(width: 10),
                Text(
                  task.reminderTime,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
