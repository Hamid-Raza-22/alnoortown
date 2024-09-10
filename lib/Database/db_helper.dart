
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
  _onCreate(Database db, int version) async {
    // List of all table creation queries
    List<String> tableQueries = [
      "CREATE TABLE IF NOT EXISTS machine(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, machine TEXT, date TEXT ,time TEXT,timeIn TEXT, timeOut TEXT)",
      "CREATE TABLE IF NOT EXISTS tanker(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, tankerNo TEXT,date TEXT,time TEXT )",
      "CREATE TABLE IF NOT EXISTS Excavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT,date TEXT,time TEXT )",
      "CREATE TABLE IF NOT EXISTS filing(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, status TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS manholes(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS pipeline(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS light(id INTEGER PRIMARY KEY,blockNo TEXT, status TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS polesExcavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, lengthTotal TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS poles(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, totalLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS asphalt(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, numOfTons TEXT,backFillingStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS brick(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS iron(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT ,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS drain(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS slab(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, numOfCompSlab TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS plaster(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS shuttering(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS shifting(id INTEGER PRIMARY KEY,fromBlock TEXT, toBlock TEXT, numOfShift TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mosque(id INTEGER PRIMARY KEY,blockNo TEXT, completionStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS newMaterials(id INTEGER PRIMARY KEY,sand TEXT, soil TEXT, base TEXT, subBase TEXT,waterBound TEXT,otherMaterial TEXT,otherMaterialValue TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS attendanceIn(id INTEGER PRIMARY KEY,timeIn TEXT, latitude TEXT, longitude TEXT, liveAddress TEXT,date TEXT)",
      "CREATE TABLE IF NOT EXISTS attendanceOut(id INTEGER PRIMARY KEY,timeOut TEXT, latitude TEXT, longitude TEXT, addressOut TEXT,date TEXT)",
      "CREATE TABLE IF NOT EXISTS foundation(id INTEGER PRIMARY KEY,blockNo TEXT, brickWork TEXT,mudFiling TEXT,plasterWork TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS floor(id INTEGER PRIMARY KEY,blockNo TEXT, brickWork TEXT,mudFiling TEXT,plasterWork TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS tiles(id INTEGER PRIMARY KEY,blockNo TEXT, tilesWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS sanitary(id INTEGER PRIMARY KEY,blockNo TEXT, sanitaryWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS ceiling(id INTEGER PRIMARY KEY,blockNo TEXT, ceilingWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS paint(id INTEGER PRIMARY KEY,blockNo TEXT, paintWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS electricity(id INTEGER PRIMARY KEY,blockNo TEXT, electricityWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS boundary(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, boundaryWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS cubStone(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, cubStonesCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS gazebo(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,gazeboWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS entrance(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,mainEntranceTilesWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS stage(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,mainStageWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mud(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, totalDumpers TEXT, mudFillingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS plant(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, plantationCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS area(id INTEGER PRIMARY KEY,typeOfWork TEXT,startDate TEXT, expectedCompDate TEXT,sittingAreaCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS walk(id INTEGER PRIMARY KEY,typeOfWork TEXT,startDate TEXT, expectedCompDate TEXT, walkingTracksCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mpMud(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,totalDumpers TEXT, mpMudFillingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mpGrass(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,grassWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mpCurbStone(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpCurbStoneCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mpLight(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpLCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mpPlant(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpPCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS door(id INTEGER PRIMARY KEY,blockNo TEXT, doorsWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS subBase(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, baseSubBaseCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS cWaterBound(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, waterBoundCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS sandCompaction(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,sandCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS soilCompaction(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,  soilCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS roadSide(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, roadsEdgingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS roadShoulder(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, roadsShoulderCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS monument(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, monumentsWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS waterFirst(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,waterSupplyCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS backFillingWs(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,  waterSupplyBackFillingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS roadSB(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, fromPlotNo TEXT, toPlotNo TEXT, roadSide TEXT, compStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS roadCurbStone(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, compStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS streetRoadWCh(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT,  noOfWaterChannels TEXT,waterChCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS canopy(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS gateFoundation(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS gatePilar(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS grey(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, fromPlotNo TEXT, toPlotNo TEXT,compStatus TEXT,date TEXT,time TEXT)"
    ];

    for (var query in tableQueries) {
      await db.execute(query);
    }
  }


}

