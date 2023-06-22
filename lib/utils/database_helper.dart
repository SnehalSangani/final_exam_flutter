import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper {
  Database? database;

  Future<Database?> checkdb() async {
    if (database != null) {
      return database;
    } else {
      return await initdb();
    }
  }

  Future<Database?> initdb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "rnw.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE TODO (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,date TEXT,time TEXT,desc TEXT,priority TEXT )";
        db.execute(query);
      },
    );
  }

  Future<void> insertdata({required title,required date,required time,required desc,required priority})
  async {
    database= await checkdb();
    database!.insert("TODO", {
      "title":title,
      "time":time,
      "date":date,
      "desc":desc,
      "priority":priority,
    });
  }

  Future<List<Map>> readdata() async {
    database = await checkdb();
    String query = "SELECT * FROM TODO";
    List<Map> list = await database!.rawQuery(query);
    return list;
  }

  Future<void> deletedata({required id}) async {
    database = await checkdb();
    database!.delete('TODO', where: "id=?", whereArgs: [id]);
  }
  Future<void> updatedata(
      {required id,
        required title,
        required desc,
        required time,
        required date,
        required priority}) async {
    database = await checkdb();
    database!.update(
        'TODO',
        {
          "title":title,
          "time":time,
          "date":date,
          "desc":desc,
          "priority":priority,
        },
        where: 'id=?',
        whereArgs: [id]);
  }
}
