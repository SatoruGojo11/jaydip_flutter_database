import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  Dbhelper._();

  static final Dbhelper instance = Dbhelper._();

  static const databasename = 'Student.db';
  static const tablename = 'Info';
  static const clmid = 'ID';
  static const clmname = 'Name';
  static const clmemail = 'Email_id';
  static const clmage = 'Age';

  static Database? dbms;

  Future<Database> get getdatabase async {
    if (dbms != null) return dbms!;

    dbms = await initDatabase();
    return dbms!;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, databasename);
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $tablename(
      $clmid INTEGER PRIMARY KEY,
      $clmname TEXT NOT NULL,
      $clmemail TEXT NOT NULL,
      $clmage INTEGER NOT NULL
      )
      ''');
  }

  Future<int> insertData(Map<String, dynamic> data) async {
    Database db = await instance.getdatabase;
    return await db.insert(tablename, data);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await instance.getdatabase;
    return await db.query(tablename);
  }

  Future<int> updateData(Map<String, dynamic> data) async {
    Database db = await instance.getdatabase;
    int clmid = data[Dbhelper.clmid];
    return await db.update(
      tablename,
      data,
      where: '${Dbhelper.clmid} =?',
      whereArgs: [clmid],
    );
  }

  Future<int> deleteData(int id) async {
    Database db = await instance.getdatabase;
    return await db.delete(
      tablename,
      where: '$clmid =?',
      whereArgs: [id],
    );
  }
}
