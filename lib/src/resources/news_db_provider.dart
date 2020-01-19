import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {
  Database db;

  final _version = 1;

  void onDatabaseCreated(Database newDb, int version) {
    newDb.execute("""
    CREATE TABLE Items(
      id INTEGER PRIMARY KEY,
      type TEXT,
      by TEXT,
      time TEXT,
      text TEXT,
      parent TEXT,
      kids BLOB,
      dead INTEGER,
      deleted INTEGER,
      url TEXT,
      score INTEGER,
      title TEXT,
      descendants INTEGER
    )
    """);
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = '${documentsDirectory.path}items.db';
    print(path);
    db = await openDatabase(
      path,
      version: _version,
      onCreate: onDatabaseCreated,
    );
  }

  getNewsItems(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return maps;
    }

    return null;
  }
}
