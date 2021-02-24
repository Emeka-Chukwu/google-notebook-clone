import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import '../model/client.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "NoteAppFlutter.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Note ( id INTEGER PRIMARY KEY,description TEXT,category VARCHAR,categoryNum INTEGER,dateTime VARCHAR)");
    });
  }

  createNewNote(NoteModel newNote) async {
    newNote.dateTime = newNote.date.toString();
    // newNote.date = null;
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Note");
    int id = table.first["id"] ?? 1;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Note (id,description,category,categoryNum, dateTime)"
        " VALUES (?,?,?,?,?)",
        [
          id,
          newNote.description,
          newNote.category,
          newNote.categoryNum,
          newNote.dateTime,
        ]);
    return raw;
  }

  updateNote(NoteModel newClient) async {
    final db = await database;
    var res = await db.update("Note", newClient.toJson(),
        where: "id = ?", whereArgs: [newClient.id]);
    print(res);
    return res;
  }

  getNote(int id) async {
    final db = await database;
    var res = await db.query("Note", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? NoteModel.fromJson(res.first) : null;
  }

  // Future<List<NoteModel>> getBlockedClients() async {
  //   final db = await database;

  //   print("works");
  //   // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
  //   var res = await db.query("Note", where: "blocked = ? ", whereArgs: [1]);

  //   List<Client> list =
  //       res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
  //   return list;
  // }

  Future<List<NoteModel>> getAllNotes() async {
    final db = await database;
    var res = await db.rawQuery(
      "select * from Note ORDER BY dateTime DESC;",
    );
    List<NoteModel> list =
        res.isNotEmpty ? res.map((c) => NoteModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteNotes(int id) async {
    final db = await database;
    return db.delete("Note", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete from Note");
  }
}
