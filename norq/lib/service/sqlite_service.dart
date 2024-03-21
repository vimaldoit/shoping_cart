import 'package:flutter/material.dart';
import 'package:norq/data/models/cart_model.dart';
import 'package:norq/data/models/product_model.dart';

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
          "CREATE TABLE Cart(id INTEGER PRIMARY KEY,title TEXT,price,description TEXT NOT NULL,category TEXT NOT NULL,image TEXT NOT NULL,itemCount INT)",
        );
      },
      version: 1,
    );
  }

  static Future<int> createItem(CartItem item) async {
    int result = 0;
    final Database db = await initializeDB();
    final id = await db.insert('Cart', item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<CartItem>> getItems() async {
    final db = await SqlliteService.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('Cart');
    return queryResult.map((e) => CartItem.fromJson(e)).toList();
  }

  static Future<void> deleteitem(String id) async {
    final db = await SqlliteService.initializeDB();
    try {
      await db.delete("Cart", where: "id=?", whereArgs: [id]);
    } catch (e) {
      debugPrint("something went wrong" + e.toString());
    }
  }

  static Future<void> updateCount(String id, String count) async {
    final db = await SqlliteService.initializeDB();
    try {
      await db.rawUpdate('''
    UPDATE Cart
    SET itemCount=? 
    WHERE id = ?
    ''', [count, id]);
    } catch (e) {
      debugPrint("something went wrong" + e.toString());
    }
  }
}
