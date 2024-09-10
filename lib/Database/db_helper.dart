import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';

import '../Globals/globals.dart';

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
      "CREATE TABLE IF NOT EXISTS waterTanker(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, tankerNo TEXT,date TEXT,time TEXT )",
      "CREATE TABLE IF NOT EXISTS excavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT,date TEXT,time TEXT )",
      "CREATE TABLE IF NOT EXISTS backFiling(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, status TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS manholes(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS pipeLaying(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS lightWires(id INTEGER PRIMARY KEY,blockNo TEXT, status TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS polesExcavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, lengthTotal TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS poles(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, totalLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS asphaltWork(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, numOfTons TEXT,backFillingStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS brickWork(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS ironWork(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT ,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS drainExcavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS manHolesSlabs(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, numOfCompSlab TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS plasterWork(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS shutteringWork(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS shiftingWork(id INTEGER PRIMARY KEY,fromBlock TEXT, toBlock TEXT, numOfShift TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mosqueExcavationWork(id INTEGER PRIMARY KEY,blockNo TEXT, completionStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS newMaterials(id INTEGER PRIMARY KEY,sand TEXT, soil TEXT, base TEXT, subBase TEXT,waterBound TEXT,otherMaterial TEXT,otherMaterialValue TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS attendanceIn(id INTEGER PRIMARY KEY,timeIn TEXT, latitude TEXT, longitude TEXT, liveAddress TEXT,date TEXT)",
      "CREATE TABLE IF NOT EXISTS attendanceOut(id INTEGER PRIMARY KEY,timeOut TEXT, latitude TEXT, longitude TEXT, addressOut TEXT,date TEXT)",
      "CREATE TABLE IF NOT EXISTS foundationWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, brickWork TEXT,mudFiling TEXT,plasterWork TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS firstFloorMosque(id INTEGER PRIMARY KEY,blockNo TEXT, brickWork TEXT,mudFiling TEXT,plasterWork TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS tilesWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, tilesWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS sanitaryWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, sanitaryWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS ceilingWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, ceilingWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS paintWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, paintWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS electricityWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, electricityWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS boundaryGrillWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, boundaryWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS curbStonesWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, cubStonesCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS gazeboWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,gazeboWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mainEntranceTilesWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,mainEntranceTilesWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mainStage(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,mainStageWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mudFillingWorkFountainPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, totalDumpers TEXT, mudFillingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS plantationWorkFountainPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, plantationCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS sittingAreaWork(id INTEGER PRIMARY KEY,typeOfWork TEXT,startDate TEXT, expectedCompDate TEXT,sittingAreaCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS walkingTracksWork(id INTEGER PRIMARY KEY,typeOfWork TEXT,startDate TEXT, expectedCompDate TEXT, walkingTracksCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mudFillingMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,totalDumpers TEXT, mpMudFillingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS grassWorkMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,grassWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS curbStonesWorkMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpCurbStoneCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS fancyLightPolesMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpLCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS plantationWorkMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpPCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS doorsWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, doorsWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS baseSubBaseCompaction(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, baseSubBaseCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS compactionAfterWaterBound(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, waterBoundCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS sandCompaction(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,sandCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS soilCompaction(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,  soilCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS roadsEdging(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, roadsEdgingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS roadShoulder(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, roadsShoulderCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS monumentWorks(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, monumentsWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS roadsWaterSupplyWork(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,waterSupplyCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS WaterSupplyBackFilling(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,  waterSupplyBackFillingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS roadsSignBoards(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, fromPlotNo TEXT, toPlotNo TEXT, roadSide TEXT, compStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS roadCurbStone(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, compStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS streetRoadWaterChannels(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT,  noOfWaterChannels TEXT,waterChCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS mainGateCanopyColumnPouringWork(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS foundationWorkMainGate(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS pillarsBrickWorkMainGate(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameGreyStructureMainGate(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)"
          "CREATE TABLE IF NOT EXISTS plasterWorkMainGate(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)"
    ];
    for (var query in tableQueries) {
      await db.execute(query);
    }
    }

}