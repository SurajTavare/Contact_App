import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper getInstacnce = DBHelper._();
  Database? myDB;
  final String tableName = "contacts";
  final String colId = "id";
  final String colName = "name";
  final String colNumber = "number";
  final String colFav = "favourite";

  Future<Database> getDB() async {
    myDB ??= await openDB();
    return await myDB!;
  }

  Future<Database> openDB() async {
    Directory dirPath = await getApplicationDocumentsDirectory();
    String path = join(dirPath.path, "contactDB.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query =
            "CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colNumber TEXT, $colFav TEXT)";
        await db.execute(query);
      },
    );
  }

  void addContact({required String name, required String number}) async {
    final db = await getDB();
    db.insert(tableName, {colName: name, colNumber: number, colFav: "false"});
  }

  Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await getDB();
    List<Map<String, dynamic>> myContacts = await db.query(tableName);
    return myContacts;
  }

  void deleteContact({required String id}) async {
    final db = await getDB();
    db.delete(tableName, where: "$colId=?", whereArgs: [id]);
  }

  void updateContact(String? name, String? number, String id) async {
    final db = await getDB();
    db.update(
      tableName,
      {colName: name, colNumber: number},
      where: "$colId=?",
      whereArgs: [id],
    );
  }

  void UpdatingFavContact(String text, String id) async {
    final db = await getDB();
    db.update(tableName, {colFav: text}, where: "$colId=?", whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getFavContacts() async {
    final db = await getDB();
    List<Map<String, dynamic>> myFavContacts = await db.query(
      tableName,
      where: "$colFav=?",
      whereArgs: ['true'],
    );
    return myFavContacts;
  }
}
