import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'greetings.db');

    return await openDatabase(
      dbPath,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE greetings(id INTEGER PRIMARY KEY AUTOINCREMENT, message TEXT)",
        );
        await db.execute(
          "CREATE TABLE preferencias(id INTEGER PRIMARY KEY AUTOINCREMENT, gusto TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertPreferencia(Preferencia preferencia) async {
    final db = await database;
    await db.insert('preferencias', preferencia.toMap());
  }

  Future<void> insertGreeting(Greeting greeting) async {
    final db = await database;
    await db.insert('greetings', greeting.toMap());
  }

  Future<void> deleteAllGreetings() async {
    final db = await database;
    await db.delete('greetings');
  }

  Future<void> deleteAllPreferences() async {
    final db = await database;
    await db.delete('preferencias');
  }

  Future<List<Greeting>> getGreetings() async {
    final db = await database;
    var greetingsMapList = await db.query('greetings');
    return List.generate(greetingsMapList.length, (i) {
      return Greeting.fromMap(greetingsMapList[i]);
    });
  }

  Future<List<Preferencia>> getPreferencias() async {
    final db = await database;
    var preferenciasMapList = await db.query('preferencias');
    return List.generate(preferenciasMapList.length, (i) {
      return Preferencia.fromMap(preferenciasMapList[i]);
    });
  }
}