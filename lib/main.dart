import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_flow/screens/home.dart';
import 'package:task_flow/screens/new_note.dart';
import 'package:task_flow/screens/task_screen.dart';
import 'package:task_flow/tasks.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => TaskList(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Main()),
    ),
  );
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    final taskList = Provider.of<TaskList>(context, listen: false);
    taskList.loadTask();
    super.initState();
  }

  List<Widget> screen = [TaskScreen(), Home(), NewNote()];
  int _currentScreen = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Task Flow",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () => print("Dark mode"),
            icon: Icon(Icons.dark_mode_outlined),
          ),
        ],
      ),
      body: screen[_currentScreen],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),

        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Color.fromARGB(255, 75, 151, 196),

          currentIndex: _currentScreen,
          onTap: (value) => setState(() {
            _currentScreen = value;
          }),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_outlined),
              label: "Task",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: "New",
            ),
          ],
        ),
      ),
    );
  }
}
