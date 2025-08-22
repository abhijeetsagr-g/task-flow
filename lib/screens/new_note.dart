import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/features/features/snackbar.dart';
import 'package:task_flow/features/notification_service.dart';
import 'package:task_flow/features/tasks.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key});

  @override
  State<NewNote> createState() => NewNoteState();
}

class NewNoteState extends State<NewNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? reminderDateTime;

  String formatReminderDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat("d MMMM ''yy h:mm a");
    return formatter.format(dateTime);
  }

  Future<void> pickDateTime() async {
    // Pick a date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (pickedDate == null) return; // user cancelled

    // Step 2: Pick a time
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: TimeOfDay.now().hour + 1,
        minute: TimeOfDay.now().minute,
      ),
    );

    if (pickedTime == null) return; // user cancelled

    if (pickedTime.isBefore(TimeOfDay.now())) {
      pickedTime = null;
      pickedDate = null;
      showSnackbar(
        context,
        "You trying to set a time in the past",
        Colors.blueAccent,
      );
      return;
    }

    // Merge both into a DateTime
    final DateTime pickedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      reminderDateTime = pickedDateTime;
    });
  }

  void onSave() {
    if (_titleController.text.isEmpty) {
      showSnackbar(context, "Title is empty, nothing is saved", Colors.red);
      return;
    }
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final String time = reminderDateTime != null
        ? formatReminderDateTime(reminderDateTime!)
        : "";
    final taskList = Provider.of<TaskList>(context, listen: false);

    Task newTask = Task(
      taskList.tasks.length + 1,
      title,
      description,
      time,
      false,
    );
    taskList.addItems(newTask);

    if (reminderDateTime != null) {
      NotificationService.showNotification(
        index: taskList.tasks.length + 1,
        title: title,
        body: "Reminder set for $time",
      );

      showSnackbar(context, "Saved and added the reminder", Colors.green);
    } else {
      showSnackbar(
        context,
        "Saved without a reminder, you can change it from the note",
        Colors.deepOrange,
      );
    }
    _titleController.clear();
    _descriptionController.clear();
    reminderDateTime = null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("New Note", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 20),

              // Title
              Text("Title"),
              SizedBox(height: 10),
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Give a title",
                ),
              ),

              SizedBox(height: 20),

              // Description
              Text("Description"),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                minLines: 3,
                maxLines: null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter Description...",
                ),
              ),

              SizedBox(height: 20),

              Text("Reminder"),
              SizedBox(height: 10),
              InkWell(
                onTap: () => pickDateTime(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        //padding: EdgeInsets.all(5),
                        height: 35,
                        child: Text(
                          reminderDateTime != null
                              ? formatReminderDateTime(reminderDateTime!)
                              : "Set a alarm",

                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() {
                          reminderDateTime = null;
                        }),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      onSave();
                    });
                  },
                  child: Text("Save", style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
