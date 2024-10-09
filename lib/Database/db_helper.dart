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
      "CREATE TABLE IF NOT EXISTS $tableNameMachine(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT,user_id TEXT, machine TEXT, machine_date TEXT ,time TEXT,time_in TEXT, time_out TEXT,  posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameWaterTanker(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, tanker_no TEXT,water_tanker_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0 )",
      "CREATE TABLE IF NOT EXISTS $tableNameExcavation(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, length TEXT,excavation_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0 )",
      "CREATE TABLE IF NOT EXISTS $tableNameBackFiling(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, status TEXT,back_filling_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameManholes(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, no_of_manholes TEXT,manholes_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePipeLaying(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, length TEXT,pipe_laying_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameLightWires(id INTEGER PRIMARY KEY,block_no TEXT, light_wire_work_status TEXT,street_no TEXT,total_length TEXT,light_wire_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePolesExcavation(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, no_of_excavation TEXT,poles_excavation_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePoles(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, no_of_poles TEXT,poles_date TEXT,time TEXT, user_id TEXT,posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameAsphaltWork(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, no_of_tons TEXT,back_filling_status TEXT,asphalt_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameBrickWork(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, completed_length TEXT,brick_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameIronWork(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, completed_length TEXT ,iron_works_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMainDrainExcavation(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, completed_length TEXT,main_drain_excavation_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameManHolesSlabs(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, no_of_comp_slabs TEXT,manholes_slabs_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePlasterWork(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, completed_length TEXT,plaster_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameShutteringWork(id INTEGER PRIMARY KEY,block_no TEXT, street_no TEXT, completed_length TEXT,shuttering_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameShiftingWork(id INTEGER PRIMARY KEY,from_block TEXT, to_block TEXT, no_of_shift TEXT,shifting_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMosqueExcavationWork(id INTEGER PRIMARY KEY,block_no TEXT, completion_status TEXT,mosque_excavation_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameNewMaterials(id INTEGER PRIMARY KEY,sand TEXT, soil TEXT, base TEXT, sub_base TEXT,water_bound TEXT,other_material TEXT,other_material_value TEXT,new_material_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameAttendanceIn(id INTEGER PRIMARY KEY,time_in TEXT, latitude TEXT, longitude TEXT, live_address TEXT,attendance_in_date TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameAttendanceOut(id INTEGER PRIMARY KEY,time_out TEXT, latitude TEXT, longitude TEXT, address_out TEXT,attendance_out_date TEXT TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameFoundationWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, brick_work TEXT,mud_filling TEXT,plaster_work TEXT,foundation_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameFirstFloorMosque(id INTEGER PRIMARY KEY,block_no TEXT, brick_work TEXT, mud_filling TEXT, plaster_work TEXT,first_floor_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameTilesWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, tiles_work_status TEXT,tiles_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameSanitaryWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, sanitary_work_status TEXT,sanitary_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameCeilingWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, ceiling_work_status TEXT,ceiling_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePaintWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, paint_work_status TEXT,paint_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameElectricityWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, electricity_work_status TEXT,electricity_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameBoundaryGrillWork(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT, boundary_work_comp_status TEXT,boundary_grill_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameCurbStonesWork(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT, curbstones_comp_status TEXT,curbstones_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameGazeboWork(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT,gazebo_work_comp_status TEXT,gazebo_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMainEntranceTilesWork(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT,main_entrance_tiles_work_comp_status TEXT,main_entrance_tiles_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMainStage(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT,main_stage_work_comp_status TEXT,main_stage_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMudFillingWorkFountainPark(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT, total_dumpers TEXT, mud_filling_comp_status TEXT,mud_filling_date TEXT,time TEXT, user_id TEXT,posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePlantationWorkFountainPark(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT, plantation_comp_status TEXT,plantation_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameSittingAreaWork(id INTEGER PRIMARY KEY,type_of_work TEXT,start_date TEXT, expected_comp_date TEXT,sitting_area_comp_status TEXT,sitting_area_date TEXT,time TEXT,user_id TEXT,block TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameWalkingTracksWork(id INTEGER PRIMARY KEY,type_of_work TEXT,start_date TEXT, expected_comp_date TEXT, walking_tracks_comp_status TEXT,walking_tracks_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMudFillingMiniPark(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT,total_dumpers TEXT, mini_park_mud_filling_comp_status TEXT,mini_park_mud_filling_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameGrassWorkMiniPark(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT,grass_work_comp_status TEXT,grass_work_date TEXT,time TEXT, user_id TEXT,posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameCurbStonesWorkMiniPark(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT, mini_park_curbstone_comp_status TEXT,mini_park_curbstone_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameFancyLightPolesMiniPark(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT, mini_park_fancy_light_comp_status TEXT,mini_park_fancy_light_poles_date TEXT,time TEXT, user_id TEXT,posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePlantationWorkMiniPark(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT, mini_park_plantation_comp_status TEXT,mini_park_plantation_date TEXT,time TEXT, user_id TEXT,posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameDoorsWorkMosque(id INTEGER PRIMARY KEY,block_no TEXT, doors_work_status TEXT, doors_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameBaseSubBaseCompaction(id INTEGER PRIMARY KEY,block_no TEXT, road_no TEXT, total_length TEXT, start_date TEXT, expected_comp_date TEXT, base_sub_base_comp_status TEXT,base_sub_base_compaction_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameCompactionAfterWaterBound(id INTEGER PRIMARY KEY,block_no TEXT, road_no TEXT, total_length TEXT, start_date TEXT, expected_comp_date TEXT, water_bound_comp_status TEXT,compaction_water_bound_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameSandCompaction(id INTEGER PRIMARY KEY,block_no TEXT, road_no TEXT, total_length TEXT, start_date TEXT, expected_comp_date TEXT,sand_comp_status TEXT,sand_compaction_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameSoilCompaction(id INTEGER PRIMARY KEY,block_no TEXT, road_no TEXT, total_length TEXT, start_date TEXT, expected_comp_date TEXT,  soil_comp_status TEXT,soil_compaction_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameRoadsEdging(id INTEGER PRIMARY KEY,block_no TEXT, road_no TEXT, road_side TEXT, total_length TEXT, start_date TEXT, expected_comp_date TEXT, roads_edging_comp_status TEXT,roads_edging_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameRoadShoulder(id INTEGER PRIMARY KEY,block_no TEXT, road_no TEXT, road_side TEXT, total_length TEXT, start_date TEXT, expected_comp_date TEXT, roads_shoulder_comp_status TEXT,roads_shoulder_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMonumentWork(id INTEGER PRIMARY KEY,start_date TEXT, expected_comp_date TEXT, monuments_work_comp_status TEXT, monuments_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameRoadsWaterSupplyWork(id INTEGER PRIMARY KEY,block_no TEXT, road_no TEXT, road_side TEXT, total_length TEXT, start_date TEXT, expected_comp_date TEXT,roads_water_supply_comp_status TEXT,roads_water_supply_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameWaterSupplyBackFilling(id INTEGER PRIMARY KEY,block_no TEXT, road_no TEXT, road_side TEXT, total_length TEXT, start_date TEXT, expected_comp_date TEXT,  water_supply_back_filling_comp_status TEXT,back_filling_water_supply_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameRoadsSignBoards(id INTEGER PRIMARY KEY,block_no TEXT, road_no TEXT, from_plot_no TEXT, to_plot_no TEXT, road_side TEXT, comp_status TEXT,roads_sign_boards_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameRoadCurbStone(id INTEGER PRIMARY KEY,block_no TEXT, road_no TEXT, total_length TEXT, comp_status TEXT,roads_curbstone_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameStreetRoadWaterChannels(id INTEGER PRIMARY KEY,block_no TEXT, road_no TEXT, road_side TEXT,  no_of_water_channels TEXT,water_channels_comp_status TEXT,street_roads_water_channel_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameMainGateCanopyColumnPouringWork(id INTEGER PRIMARY KEY,block_no TEXT, work_status TEXT,canopy_column_pouring_main_gate_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameFoundationWorkMainGate(id INTEGER PRIMARY KEY,block_no TEXT, work_status TEXT,main_gate_foundation_date TEXT,time TEXT, user_id TEXT,posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePillarsBrickWorkMainGate(id INTEGER PRIMARY KEY,block_no TEXT, work_status TEXT,main_gate_pillar_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameGreyStructureMainGate(id INTEGER PRIMARY KEY,block_no TEXT, work_status TEXT,main_gate_grey_structure_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNamePlasterWorkMainGate(id INTEGER PRIMARY KEY,block_no TEXT, work_status TEXT,main_gate_plaster_work_date TEXT,time TEXT,user_id TEXT, posted INTEGER DEFAULT 0)",
      "CREATE TABLE IF NOT EXISTS $tableNameRoadsDetail(id INTEGER PRIMARY KEY,phase TEXT, block TEXT,street TEXT,length TEXT, road_type TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameBlocksDetails(id INTEGER PRIMARY KEY, block TEXT,marla TEXT,plot_no TEXT)",
      "CREATE TABLE IF NOT EXISTS $tableNameLogin(id INTEGER PRIMARY KEY AUTOINCREMENT,user_name TEXT,contact TEXT,cnic TEXT,image TEXT,address TEXT,user_id TEXT,city TEXT,password TEXT)",
    ];
    for (var query in tableQueries) {
      await db.execute(query);
    }
  }
}