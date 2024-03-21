import 'package:flutter/material.dart';
import 'package:localapp/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqlliteService {
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    print(path);
    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Notes(id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  static Future<int> createItem(Note note) async {
    int result = 0;
    final Database db = await initializeDB();
    final id = await db.insert('Notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Note>> getItems() async {
    final db = await SqlliteService.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('Notes');
    return queryResult.map((e) => Note.fromMap(e)).toList();
  }

  static Future<void> deleteitem(String id) async {
    final db = await SqlliteService.initializeDB();
    try {
      await db.delete("Notes", where: "id=?", whereArgs: [id]);
    } catch (e) {
      debugPrint("something went wrong" + e.toString());
    }
  }
}
