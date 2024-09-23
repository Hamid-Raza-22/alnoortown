import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';

import '../Globals/globals.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'alNoor.db');
    var db = openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    // List of all table creation queries
    List<String> tableQueries = [
      "CREATE TABLE IF NOT EXISTS $tableNameMachine(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, machine TEXT, date TEXT ,time TEXT,timeIn TEXT, timeOut TEXT,  posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameWaterTanker(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, tanker_no TEXT,water_tanker_date TEXT,time TEXT, posted INTEGER DEFAULT 0 )",
      "CREATE TABLE IF NOT EXISTS $tableNameExcavation(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, length TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0 )",
      "CREATE TABLE IF NOT EXISTS $tableNameBackFiling(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, status TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameManholes(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, noOfManholes TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePipeLaying(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, length TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameLightWires(id INTEGER PRIMARY KEY,block_no TEXT, lightWireWorkStatus TEXT,street_no TEXT,totalLength TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePolesExcavation(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, noOfExcavation TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePoles(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, noOfPoles TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameAsphaltWork(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, numOfTons TEXT,backFillingStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameBrickWork(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, completedLength TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameIronWork(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, completedLength TEXT ,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameDrainExcavation(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, completedLength TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameManHolesSlabs(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, numOfCompSlab TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePlasterWork(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, completedLength TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameShutteringWork(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, completedLength TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameShiftingWork(id INTEGER PRIMARY KEY,fromBlock TEXT, toBlock TEXT, numOfShift TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMosqueExcavationWork(id INTEGER PRIMARY KEY,block_no TEXT, completionStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameNewMaterials(id INTEGER PRIMARY KEY,sand TEXT, soil TEXT, base TEXT, subBase TEXT,waterBound TEXT,otherMaterial TEXT,otherMaterialValue TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameAttendanceIn(id INTEGER PRIMARY KEY,timeIn TEXT, latitude TEXT, longitude TEXT, liveAddress TEXT,date TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameAttendanceOut(id INTEGER PRIMARY KEY,timeOut TEXT, latitude TEXT, longitude TEXT, addressOut TEXT,date TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameFoundationWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, brickWork TEXT,mudFiling TEXT,plasterWork TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameFirstFloorMosque(id INTEGER PRIMARY KEY,block_no TEXT, brickWork TEXT,mudFiling TEXT,plasterWork TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameTilesWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, tilesWorkStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameSanitaryWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, sanitaryWorkStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameCeilingWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, ceilingWorkStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePaintWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, paintWorkStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameElectricityWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, electricityWorkStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameBoundaryGrillWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, boundaryWorkCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameCurbStonesWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, cubStonesCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameGazeboWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,gazeboWorkCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMainEntranceTilesWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,mainEntranceTilesWorkCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMainStage(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,mainStageWorkCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMudFillingWorkFountainPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, totalDumpers TEXT, mudFillingCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePlantationWorkFountainPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, plantationCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameSittingAreaWork(id INTEGER PRIMARY KEY,typeOfWork TEXT,startDate TEXT, expectedCompDate TEXT,sittingAreaCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameWalkingTracksWork(id INTEGER PRIMARY KEY,typeOfWork TEXT,startDate TEXT, expectedCompDate TEXT, walkingTracksCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMudFillingMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,totalDumpers TEXT, mpMudFillingCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameGrassWorkMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT,grassWorkCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameCurbStonesWorkMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpCurbStoneCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameFancyLightPolesMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpLCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePlantationWorkMiniPark(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, mpPCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameDoorsWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, doorsWorkStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameBaseSubBaseCompaction(id INTEGER PRIMARY KEY,block_no TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, baseSubBaseCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameCompactionAfterWaterBound(id INTEGER PRIMARY KEY,block_no TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, waterBoundCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameSandCompaction(id INTEGER PRIMARY KEY,block_no TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,sandCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameSoilCompaction(id INTEGER PRIMARY KEY,block_no TEXT, roadNo TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,  soilCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameRoadsEdging(id INTEGER PRIMARY KEY,block_no TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, roadsEdgingCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameRoadShoulder(id INTEGER PRIMARY KEY,block_no TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT, roadsShoulderCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMonumentWork(id INTEGER PRIMARY KEY,startDate TEXT, expectedCompDate TEXT, monumentsWorkCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameRoadsWaterSupplyWork(id INTEGER PRIMARY KEY,block_no TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,waterSupplyCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameWaterSupplyBackFilling(id INTEGER PRIMARY KEY,block_no TEXT, roadNo TEXT, roadSide TEXT, totalLength TEXT, startDate TEXT, expectedCompDate TEXT,  waterSupplyBackFillingCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameRoadsSignBoards(id INTEGER PRIMARY KEY,block_no TEXT, roadNo TEXT, fromPlotNo TEXT, toPlotNo TEXT, roadSide TEXT, compStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameRoadCurbStone(id INTEGER PRIMARY KEY,block_no TEXT, roadNo TEXT, totalLength TEXT, compStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameStreetRoadWaterChannels(id INTEGER PRIMARY KEY,block_no TEXT, roadNo TEXT, roadSide TEXT,  noOfWaterChannels TEXT,waterChCompStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMainGateCanopyColumnPouringWork(id INTEGER PRIMARY KEY,block_no TEXT, workStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameFoundationWorkMainGate(id INTEGER PRIMARY KEY,block_no TEXT, workStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePillarsBrickWorkMainGate(id INTEGER PRIMARY KEY,block_no TEXT, workStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameGreyStructureMainGate(id INTEGER PRIMARY KEY,block_no TEXT, workStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePlasterWorkMainGate(id INTEGER PRIMARY KEY,block_no TEXT, workStatus TEXT,date TEXT,time TEXT, posted INTEGER DEFAULT 0)"
    ];
    for (var query in tableQueries) {
      await db.execute(query);
    }
  }
}