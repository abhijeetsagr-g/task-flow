import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_flow/features/tasks.dart';

class DatabaseHelper {
  // This makes sure we only ever have ONE DatabaseHelper.
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database; // Add this line.

  // Use a factory constructor to return the single instance.
  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  // This is the main function you'll use to get the database instance.
  Future<Database> get database async {
    // If the database is already open, return it.
    if (_database != null) {
      return _database!;
    }
    // If not, open it for the first time.
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');

    // Open the database and create the table if it doesn't exist.
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, reminderTime TEXT, isCompleted INTEGER)",
        );
      },
    );
  }

  // Insert (Put a book on the shelf)
  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all (List all the books on the shelf)
  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Delete (Remove a book)
  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
