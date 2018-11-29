import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import '../model/item.dart';

class DbProvider {
  Database db;

  void init() async {
    Directory documentDirectoty = await getApplicationDocumentsDirectory();
    final path = join(documentDirectoty.path, "items.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      db.execute("""
      CREATE TABLE Items
      (
      id INTEGER PRIMARY KEY,
      type TEXT,
      by TEXT,
      time INTEGER,
      text TEXT,
      parent INTEGER,
      kids BLOB,
      dead INTEGER,
      deleted INTEGER,
      url TEXT,
      score INTEGER,
      title TEXT,
      descendants INTEGER
      )
      
      """);
    });
  }

  Future<Item> fetchItem(int id) async {
    final map = await db.query(
      "Items",
      columns: null,
      where: "id=?",
      whereArgs: [id],
    );

    if (map.length > 0) {
      return Item.fromDb(map.first);
    }

    return null;
  }

  Future<int> addItem(Item item) {
    db.insert("Items", item.toMapForDb());
  }
}
