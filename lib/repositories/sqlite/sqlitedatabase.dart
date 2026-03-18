import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Map<int, String> scripts = {
  1: ''' CREATE TABLE tarefas (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT,
          concluido INTEGER
          );
  ''',
  2: ''' CREATE TABLE imc (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            peso TEXT,
            altura TEXT,
            imc REAL
          );
  ''',
};

class SQLiteDataBase {
  static Database? db;

  Future<Database> obterDataBase() async {
    db ?? (db = await iniciarBancoDeDados());
    return db!;
  }

  Future<Database> iniciarBancoDeDados() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');
    var database = await openDatabase(
        path,
        version: scripts.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]!);
      }
    });
    return database;
  }
}