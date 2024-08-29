
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
  _onCreate(Database db, int version) {
    db.execute(
        "CREATE TABLE machine(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, machine TEXT, timeIn TEXT, timeOut TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE tanker(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, tankerNo TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE Excavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE filing(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, status TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE manholes(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE pipeline(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE light(id INTEGER PRIMARY KEY,blockNo TEXT, status TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE polesExcavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, lengthTotal TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE poles(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, totalLength TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE asphalt(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, numOfTons TEXT,backFillingStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE brick(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE iron(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT, date TEXT )");
    db.execute(
        "CREATE TABLE drain(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE slab(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, numOfCompSlab TEXT,date TEXT)");
    db.execute(
        "CREATE TABLE plaster(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT)");
    db.execute(
        "CREATE TABLE shuttering(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT)");
    db.execute(
        "CREATE TABLE shifting(id INTEGER PRIMARY KEY,fromBlock TEXT, toBlock TEXT, numOfShift TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE mosque(id INTEGER PRIMARY KEY,blockNo TEXT, completionStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE newMaterials(id INTEGER PRIMARY KEY,sand TEXT, soil TEXT, base TEXT, subBase TEXT,waterBound TEXT,otherMaterial TEXT,otherMaterialValue TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE attendanceIn(id INTEGER PRIMARY KEY,timeIn TEXT, latitude TEXT, longitude TEXT, liveAddress TEXT,date TEXT)");
    db.execute(
        "CREATE TABLE attendanceOut(id INTEGER PRIMARY KEY,timeOut TEXT, latitude TEXT, longitude TEXT, addressOut TEXT,date TEXT)");
    db.execute(
        "CREATE TABLE foundation(id INTEGER PRIMARY KEY,blockNo TEXT, brickWork TEXT,mudFiling TEXT,plasterWork TEXT date TEXT)");
    db.execute(
        "CREATE TABLE floor(id INTEGER PRIMARY KEY,blockNo TEXT, brickWork TEXT,mudFiling TEXT,plasterWork TEXT date TEXT)");
    db.execute(
        "CREATE TABLE tiles(id INTEGER PRIMARY KEY,blockNo TEXT, tilesWorkStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE sanitary(id INTEGER PRIMARY KEY,blockNo TEXT, sanitaryWorkStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE ceiling(id INTEGER PRIMARY KEY,blockNo TEXT, ceilingWorkStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE paint(id INTEGER PRIMARY KEY,blockNo TEXT, paintWorkStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE electricity(id INTEGER PRIMARY KEY,blockNo TEXT, electricityWorkStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE boundary(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, boundaryWorkCompStatus TEXT)");
    db.execute(
        "CREATE TABLE cubStone(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, cubStonesCompStatus TEXT)");
    db.execute(
        "CREATE TABLE gazebo(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, gazeboWorkCompStatus TEXT)");
    db.execute(
        "CREATE TABLE entrance(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mainEntranceTilesWorkCompStatus TEXT)");
    db.execute(
        "CREATE TABLE stage(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mainStageWorkCompStatus TEXT)");
    db.execute(
        "CREATE TABLE mud(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,totalDumpers TEXT, mudFillingCompStatus TEXT)");
    db.execute(
        "CREATE TABLE plant(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, plantationCompStatus TEXT)");
    db.execute(
        "CREATE TABLE area(id INTEGER PRIMARY KEY,typeOfWork TEXT,startDate TEXT, expectedCompDate TEXT, sittingAreaCompStatus TEXT)");
    db.execute(
        "CREATE TABLE walk(id INTEGER PRIMARY KEY,typeOfWork TEXT,startDate TEXT, expectedCompDate TEXT, walkingTracksCompStatus TEXT)");
    db.execute(
        "CREATE TABLE mpMud(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,totalDumpers TEXT, mudFillingCompStatus TEXT)");
    db.execute(
        "CREATE TABLE mpGrass(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, grassWorkCompStatus TEXT)");
    db.execute(
        "CREATE TABLE mpCurbStone(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpCurbStoneCompStatus TEXT)");
    db.execute(
        "CREATE TABLE mpLight(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpLCompStatus TEXT)");
    db.execute(
        "CREATE TABLE mpPlant(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpPCompStatus TEXT)");
    db.execute(
        "CREATE TABLE door(id INTEGER PRIMARY KEY,blockNo TEXT, doorsWorkStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE subBase(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, baseSubBaseCompStatus TEXT)");
    db.execute(
        "CREATE TABLE cWaterBound(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, waterBoundCompStatus TEXT)");
    db.execute(
        "CREATE TABLE sandCompaction(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, sandCompStatus TEXT)");
    db.execute(
        "CREATE TABLE soilCompaction(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, soilCompStatus TEXT)");
    db.execute(
        "CREATE TABLE roadSide(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, roadsEdgingCompStatus TEXT)");
    db.execute(
        "CREATE TABLE roadShoulder(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, roadsShoulderCompStatus TEXT)");
    db.execute(
        "CREATE TABLE waterFirst(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, waterSupplyCompStatus TEXT)");
    db.execute(
        "CREATE TABLE backFillingWs(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, waterSupplyBackFillingCompStatus TEXT)");
    db.execute(
        "CREATE TABLE roadSB(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, fromPlotNo TEXT, toPlotNo TEXT, roadSide TEXT, compStatus TEXT)");
    db.execute(
        "CREATE TABLE roadCurbStone(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, compStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE streetRoadWCh(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT,  noOfWaterChannels TEXT,waterChCompStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE canopy(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE gateFoundation(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE gatePilar(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE grey(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT, date TEXT)");
    db.execute(
        "CREATE TABLE gatePlaster(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT, date TEXT)");

  }

}

