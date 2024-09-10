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
      "CREATE TABLE IF NOT EXISTS $tableNameMachine(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, machine TEXT, date TEXT ,time TEXT,timeIn TEXT, timeOut TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameWaterTanker(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, tankerNo TEXT,date TEXT,time TEXT )",
      "CREATE TABLE IF NOT EXISTS $tableNameExcavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT,date TEXT,time TEXT )",
      "CREATE TABLE IF NOT EXISTS $tableNameBackFiling(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, status TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameManholes(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamePipeLaying(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, length TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameLightWires(id INTEGER PRIMARY KEY,blockNo TEXT, status TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamePolesExcavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, lengthTotal TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamePoles(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, totalLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameAsphaltWork(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, numOfTons TEXT,backFillingStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameBrickWork(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameIronWork(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT ,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamedrainExcavation(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamemanHolesSlabs(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, numOfCompSlab TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameplasterWork(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameshutteringWork(id INTEGER PRIMARY KEY,blockNo TEXT, streetNo TEXT, completedLength TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameshiftingWork(id INTEGER PRIMARY KEY,fromBlock TEXT, toBlock TEXT, numOfShift TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamemosqueExcavationWork(id INTEGER PRIMARY KEY,blockNo TEXT, completionStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamenewMaterials(id INTEGER PRIMARY KEY,sand TEXT, soil TEXT, base TEXT, subBase TEXT,waterBound TEXT,otherMaterial TEXT,otherMaterialValue TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameattendanceIn(id INTEGER PRIMARY KEY,timeIn TEXT, latitude TEXT, longitude TEXT, liveAddress TEXT,date TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameattendanceOut(id INTEGER PRIMARY KEY,timeOut TEXT, latitude TEXT, longitude TEXT, addressOut TEXT,date TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamefoundationWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, brickWork TEXT,mudFiling TEXT,plasterWork TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamefirstFloorMosque(id INTEGER PRIMARY KEY,blockNo TEXT, brickWork TEXT,mudFiling TEXT,plasterWork TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNametilesWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, tilesWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamesanitaryWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, sanitaryWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameceilingWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, ceilingWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamepaintWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, paintWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameelectricityWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, electricityWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameboundaryGrillWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, boundaryWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamecurbStonesWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, cubStonesCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamegazeboWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,gazeboWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamemainEntranceTilesWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,mainEntranceTilesWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamemainStage(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,mainStageWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamemudFillingWorkFountainPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, totalDumpers TEXT, mudFillingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameplantationWorkFountainPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, plantationCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamesittingAreaWork(id INTEGER PRIMARY KEY,typeOfWork TEXT,startDate TEXT, expectedCompDate TEXT,sittingAreaCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamewalkingTracksWork(id INTEGER PRIMARY KEY,typeOfWork TEXT,startDate TEXT, expectedCompDate TEXT, walkingTracksCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamemudFillingMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,totalDumpers TEXT, mpMudFillingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamegrassWorkMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,grassWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamecurbStonesWorkMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpCurbStoneCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamefancyLightPolesMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpLCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameplantationWorkMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpPCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamedoorsWorkMosque(id INTEGER PRIMARY KEY,blockNo TEXT, doorsWorkStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamebaseSubBaseCompaction(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, baseSubBaseCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamecompactionAfterWaterBound(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, waterBoundCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamesandCompaction(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,sandCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamesoilCompaction(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,  soilCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameroadsEdging(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, roadsEdgingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameroadShoulder(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, roadsShoulderCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamemonumentWorks(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, monumentsWorkCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameroadsWaterSupplyWork(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,waterSupplyCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameWaterSupplyBackFilling(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,  waterSupplyBackFillingCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameroadsSignBoards(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, fromPlotNo TEXT, toPlotNo TEXT, roadSide TEXT, compStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameroadCurbStone(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, totalLength TEXT, compStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamestreetRoadWaterChannels(id INTEGER PRIMARY KEY,blockNo TEXT, roadNo TEXT, roadSide TEXT,  noOfWaterChannels TEXT,waterChCompStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamemainGateCanopyColumnPouringWork(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamefoundationWorkMainGate(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNamepillarsBrickWorkMainGate(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameGreyStructureMainGate(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)"
          "CREATE TABLE IF NOT EXISTS $tableNameplasterWorkMainGate(id INTEGER PRIMARY KEY,blockNo TEXT, workStatus TEXT,date TEXT,time TEXT)"
    ];
    for (var query in tableQueries) {
      await db.execute(query);
    }
    }

}