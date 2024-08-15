
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io' as io;

import 'package:sqflite/sqflite.dart';


class DBHelper{
  static Database? _db;
  Future<Database> get db async{
    if(_db != null)
    {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }
  initDatabase() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'alnoor.db');
    var db = openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version){
    db.execute("CREATE TABLE machine(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, machine TEXT, timeIn TEXT, timeOut TEXT)");
    db.execute("CREATE TABLE tanker(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, tankerNo TEXT)");
    db.execute("CREATE TABLE exavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT)");
    db.execute("CREATE TABLE filing(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, status TEXT)");
    db.execute("CREATE TABLE pipeline(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT)");
    db.execute("CREATE TABLE light(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, totalLength TEXT)");
  }
}
