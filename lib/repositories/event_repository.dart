import 'dart:developer';

import 'package:big_fun_app/database/app_database.dart';
import 'package:big_fun_app/models/event.dart';
import 'package:sqflite/sqflite.dart';

class EventRepository{

  insert(Event event) async {
    Database db = await AppDatabase().openDB();
    await db.insert(AppDatabase().tableName, event.toMap());
    log(event.toMap().toString());
  }

  delete(Event event) async {
    Database db = await AppDatabase().openDB();
    await db.delete(
        AppDatabase().tableName,
        where: 'id=?',
        whereArgs: [event.id]
    );
  }

  Future<bool> isFavorite(Event event) async {
    Database db = await AppDatabase().openDB();
    List maps = await db.query(
        AppDatabase().tableName,
        where: 'id=?',
        whereArgs: [event.id]
    );
    return maps.isNotEmpty;
  }

  Future<List<Event>> getAll() async {
    Database db = await AppDatabase().openDB();
    final maps = await db.query(AppDatabase().tableName);
    return maps.map((e) => Event.fromMap(e)).toList();
  }
}