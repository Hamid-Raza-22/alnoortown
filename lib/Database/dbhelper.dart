
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
    String path = join(documentDirectory.path,'alNoor.db');
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
    db.execute("CREATE TABLE polesExavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, lengthTotal TEXT)");
    db.execute("CREATE TABLE poles(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, totalLength TEXT)");
    db.execute("CREATE TABLE asphalt(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, numOfTons TEXT,backFillingStatus TEXT)");
    db.execute("CREATE TABLE brick(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT)");
    db.execute("CREATE TABLE iron(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, numOfTons TEXT,backFillingStatus TEXT)");
    db.execute("CREATE TABLE drain(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT)");
    db.execute("CREATE TABLE slab(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, numOfCompSlab TEXT)");
    db.execute("CREATE TABLE plaster(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT)");
    db.execute("CREATE TABLE shuttering(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT)");
    db.execute("CREATE TABLE shifting(id INTEGER PRIMARY KEY,fromBlock TEXT, toBlock TEXT, numOfShift TEXT)");
    db.execute("CREATE TABLE shuttering(id INTEGER PRIMARY KEY,blockNo TEXT, completionStatus TEXT)");
    db.execute("CREATE TABLE newMaterials(id INTEGER PRIMARY KEY,sand TEXT, base TEXT, subBase TEXT,waterBound TEXT,otherMaterial TEXT)");




  }
}
