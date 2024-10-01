import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class Config {
  static late FirebaseRemoteConfig remoteConfig;

  static Future<void> initialize() async {
    remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 1),
      // Set to 1 minute for development; change to a larger interval for production
      minimumFetchInterval: Duration(seconds: 1),
    ));
    await fetchLatestConfig(); // Fetch and activate immediately
  }

  static Future<void> fetchLatestConfig() async {
    try {
      bool updated = await remoteConfig.fetchAndActivate();
      if (updated) {
        if (kDebugMode) {
          print('Remote config updated');
        }
      } else {
        if (kDebugMode) {
          print('No changes in remote config');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch remote config: $e');
      }
    }
  }
// Static configuration parameters for GET API URLs
  static String get getApiUrlMachine => remoteConfig.getString('Machine_get_url');
  static String get getApiUrlWaterTanker => remoteConfig.getString('Water_Tanker_get_url');
  static String get getApiUrlExcavation => remoteConfig.getString('Excavation_get_url');
  static String get getApiUrlBackFiling => remoteConfig.getString('Back_Filing_get_url');
  static String get getApiUrlManholes => remoteConfig.getString('Manholes_get_url');
  static String get getApiUrlPipeLaying => remoteConfig.getString('Pipe_Laying_get_url');
  static String get getApiUrlLightWires => remoteConfig.getString('Light_Wires_get_url');
  static String get getApiUrlPolesExcavation => remoteConfig.getString('Poles_Excavation_get_url');
  static String get getApiUrlPoles => remoteConfig.getString('Poles_get_url');
  static String get getApiUrlAsphaltWork => remoteConfig.getString('Asphalt_Work_get_url');
  static String get getApiUrlBrickWork => remoteConfig.getString('Brick_Work_get_url');
  static String get getApiUrlIronWork => remoteConfig.getString('Iron_Work_get_url');
  static String get getApiUrlDrainExcavation => remoteConfig.getString('Drain_Excavation_get_url');
  static String get getApiUrlManholesSlabs => remoteConfig.getString('Manholes_Slabs_get_url');
  static String get getApiUrlPlasterWork => remoteConfig.getString('Plaster_Work_get_url');
  static String get getApiUrlShutteringWork => remoteConfig.getString('Shuttering_Work_get_url');
  static String get getApiUrlShiftingWork => remoteConfig.getString('Shifting_Work_get_url');
  static String get getApiUrlMosqueExcavationWork => remoteConfig.getString('Mosque_Excavation_Work_get_url');
  static String get getApiUrlNewMaterials => remoteConfig.getString('New_Materials_get_url');
  static String get getApiUrlAttendanceIn => remoteConfig.getString('Attendance_In_get_url');
  static String get getApiUrlAttendanceOut => remoteConfig.getString('Attendance_Out_get_url');
  static String get getApiUrlFoundationWorkMosque => remoteConfig.getString('Foundation_Work_Mosque_get_url');
  static String get getApiUrlFirstFloorMosque => remoteConfig.getString('First_Floor_Mosque_get_url');
  static String get getApiUrlTilesWorkMosque => remoteConfig.getString('Tiles_Work_Mosque_get_url');
  static String get getApiUrlSanitaryWorkMosque => remoteConfig.getString('Sanitary_Work_Mosque_get_url');
  static String get getApiUrlCeilingWorkMosque => remoteConfig.getString('Ceiling_Work_Mosque_get_url');
  static String get getApiUrlPaintWorkMosque => remoteConfig.getString('Paint_Work_Mosque_get_url');
  static String get getApiUrlElectricityWorkMosque => remoteConfig.getString('Electricity_Work_Mosque_get_url');
  static String get getApiUrlBoundaryGrillWork => remoteConfig.getString('Boundary_Grill_Work_get_url');
  static String get getApiUrlCurbStonesWork => remoteConfig.getString('Curb_Stones_Work_get_url');
  static String get getApiUrlGazeboWork => remoteConfig.getString('Gazebo_Work_get_url');
  static String get getApiUrlMainEntranceTilesWork => remoteConfig.getString('Main_Entrance_Tiles_Work_get_url');
  static String get getApiUrlMainStage => remoteConfig.getString('Main_Stage_get_url');
  static String get getApiUrlMudFillingWorkFountainPark => remoteConfig.getString('Mud_Filling_Work_Fountain_Park_get_url');
  static String get getApiUrlPlantationWorkFountainPark => remoteConfig.getString('Plantation_Work_Fountain_Park_get_url');
  static String get getApiUrlSittingAreaWork => remoteConfig.getString('Sitting_Area_Work_get_url');
  static String get getApiUrlWalkingTracksWork => remoteConfig.getString('Walking_Tracks_Work_get_url');
  static String get getApiUrlMudFillingMiniPark => remoteConfig.getString('Mud_Filling_Mini_Park_get_url');
  static String get getApiUrlGrassWorkMiniPark => remoteConfig.getString('Grass_Work_Mini_Park_get_url');
  static String get getApiUrlCurbStonesWorkMiniPark => remoteConfig.getString('Curb_Stones_Work_Mini_Park_get_url');
  static String get getApiUrlFancyLightPolesMiniPark => remoteConfig.getString('Fancy_Light_Poles_Mini_Park_get_url');
  static String get getApiUrlPlantationWorkMiniPark => remoteConfig.getString('Plantation_Work_Mini_Park_get_url');
  static String get getApiUrlDoorsWorkMosque => remoteConfig.getString('Doors_Work_Mosque_get_url');
  static String get getApiUrlBaseSubBaseCompaction => remoteConfig.getString('Base_SubBase_Compaction_get_url');
  static String get getApiUrlCompactionAfterWaterBound => remoteConfig.getString('Compaction_After_Water_Bound_get_url');
  static String get getApiUrlSandCompaction => remoteConfig.getString('Sand_Compaction_get_url');
  static String get getApiUrlSoilCompaction => remoteConfig.getString('Soil_Compaction_get_url');
  static String get getApiUrlRoadsEdging => remoteConfig.getString('Roads_Edging_get_url');
  static String get getApiUrlRoadShoulder => remoteConfig.getString('Road_Shoulder_get_url');
  static String get getApiUrlMonumentWork => remoteConfig.getString('Monument_Work_get_url');
  static String get getApiUrlRoadsWaterSupplyWork => remoteConfig.getString('Roads_Water_Supply_Work_get_url');
  static String get getApiUrlWaterSupplyBackFilling => remoteConfig.getString('Water_Supply_Back_Filling_get_url');
  static String get getApiUrlRoadsSignBoards => remoteConfig.getString('Roads_Sign_Boards_get_url');
  static String get getApiUrlRoadCurbStone => remoteConfig.getString('Road_Curb_Stone_get_url');
  static String get getApiUrlStreetRoadWaterChannels => remoteConfig.getString('Street_Road_Water_Channels_get_url');
  static String get getApiUrlMainGateCanopyColumnPouringWork => remoteConfig.getString('Main_Gate_Canopy_Column_Pouring_Work_get_url');
  static String get getApiUrlFoundationWorkMainGate => remoteConfig.getString('Foundation_Work_Main_Gate_get_url');
  static String get getApiUrlPillarsBrickWorkMainGate => remoteConfig.getString('Pillars_Brick_Work_Main_Gate_get_url');
  static String get getApiUrlGreyStructureMainGate => remoteConfig.getString('Grey_Structure_Main_Gate_get_url');
  static String get getApiUrlPlasterWorkMainGate => remoteConfig.getString('Plaster_Work_Main_Gate_get_url');
  static String get getApiUrlBlocksDetails => remoteConfig.getString('Blocks_Details_get_url');
  static String get getApiUrlRoadsDetails => remoteConfig.getString('Roads_Details_get_url');
  static String get getApiUrlLogin => remoteConfig.getString('Login_get_url');

  // Static configuration parameters for POST API URLs with postApiUrl prefix
  static String get postApiUrlMachine => remoteConfig.getString('Machine_post_url');
  static String get postApiUrlWaterTanker => remoteConfig.getString('Water_Tanker_post_url');
  static String get postApiUrlExcavation => remoteConfig.getString('Excavation_post_url');
  static String get postApiUrlBackFiling => remoteConfig.getString('Back_Filing_post_url');
  static String get postApiUrlManholes => remoteConfig.getString('Manholes_post_url');
  static String get postApiUrlPipeLaying => remoteConfig.getString('Pipe_Laying_post_url');
  static String get postApiUrlLightWires => remoteConfig.getString('Light_Wires_post_url');
  static String get postApiUrlPolesExcavation => remoteConfig.getString('Poles_Excavation_post_url');
  static String get postApiUrlPoles => remoteConfig.getString('Poles_post_url');
  static String get postApiUrlAsphaltWork => remoteConfig.getString('Asphalt_Work_post_url');
  static String get postApiUrlBrickWork => remoteConfig.getString('Brick_Work_post_url');
  static String get postApiUrlIronWork => remoteConfig.getString('Iron_Work_post_url');
  static String get postApiUrlDrainExcavation => remoteConfig.getString('Drain_Excavation_post_url');
  static String get postApiUrlManholesSlabs => remoteConfig.getString('Manholes_Slabs_post_url');
  static String get postApiUrlPlasterWork => remoteConfig.getString('Plaster_Work_post_url');
  static String get postApiUrlShutteringWork => remoteConfig.getString('Shuttering_Work_post_url');
  static String get postApiUrlShiftingWork => remoteConfig.getString('Shifting_Work_post_url');
  static String get postApiUrlMosqueExcavationWork => remoteConfig.getString('Mosque_Excavation_Work_post_url');
  static String get postApiUrlNewMaterials => remoteConfig.getString('New_Materials_post_url');
  static String get postApiUrlAttendanceIn => remoteConfig.getString('Attendance_In_post_url');
  static String get postApiUrlAttendanceOut => remoteConfig.getString('Attendance_Out_post_url');
  static String get postApiUrlFoundationWorkMosque => remoteConfig.getString('Foundation_Work_Mosque_post_url');
  static String get postApiUrlFirstFloorMosque => remoteConfig.getString('First_Floor_Mosque_post_url');
  static String get postApiUrlTilesWorkMosque => remoteConfig.getString('Tiles_Work_Mosque_post_url');
  static String get postApiUrlSanitaryWorkMosque => remoteConfig.getString('Sanitary_Work_Mosque_post_url');
  static String get postApiUrlCeilingWorkMosque => remoteConfig.getString('Ceiling_Work_Mosque_post_url');
  static String get postApiUrlPaintWorkMosque => remoteConfig.getString('Paint_Work_Mosque_post_url');
  static String get postApiUrlElectricityWorkMosque => remoteConfig.getString('Electricity_Work_Mosque_post_url');
  static String get postApiUrlBoundaryGrillWork => remoteConfig.getString('Boundary_Grill_Work_post_url');
  static String get postApiUrlCurbStonesWork => remoteConfig.getString('Curb_Stones_Work_post_url');
  static String get postApiUrlGazeboWork => remoteConfig.getString('Gazebo_Work_post_url');
  static String get postApiUrlMainEntranceTilesWork => remoteConfig.getString('Main_Entrance_Tiles_Work_post_url');
  static String get postApiUrlMainStage => remoteConfig.getString('Main_Stage_post_url');
  static String get postApiUrlMudFillingWorkFountainPark => remoteConfig.getString('Mud_Filling_Work_Fountain_Park_post_url');
  static String get postApiUrlPlantationWorkFountainPark => remoteConfig.getString('Plantation_Work_Fountain_Park_post_url');
  static String get postApiUrlSittingAreaWork => remoteConfig.getString('Sitting_Area_Work_post_url');
  static String get postApiUrlWalkingTracksWork => remoteConfig.getString('Walking_Tracks_Work_post_url');
  static String get postApiUrlMudFillingMiniPark => remoteConfig.getString('Mud_Filling_Mini_Park_post_url');
  static String get postApiUrlGrassWorkMiniPark => remoteConfig.getString('Grass_Work_Mini_Park_post_url');
  static String get postApiUrlCurbStonesWorkMiniPark => remoteConfig.getString('Curb_Stones_Work_Mini_Park_post_url');
  static String get postApiUrlFancyLightPolesMiniPark => remoteConfig.getString('Fancy_Light_Poles_Mini_Park_post_url');
  static String get postApiUrlPlantationWorkMiniPark => remoteConfig.getString('Plantation_Work_Mini_Park_post_url');
  static String get postApiUrlDoorsWorkMosque => remoteConfig.getString('Doors_Work_Mosque_post_url');
  static String get postApiUrlBaseSubBaseCompaction => remoteConfig.getString('Base_SubBase_Compaction_post_url');
  static String get postApiUrlCompactionAfterWaterBound => remoteConfig.getString('Compaction_After_Water_Bound_post_url');
  static String get postApiUrlSandCompaction => remoteConfig.getString('Sand_Compaction_post_url');
  static String get postApiUrlSoilCompaction => remoteConfig.getString('Soil_Compaction_post_url');
  static String get postApiUrlRoadsEdging => remoteConfig.getString('Roads_Edging_post_url');
  static String get postApiUrlRoadShoulder => remoteConfig.getString('Road_Shoulder_post_url');
  static String get postApiUrlMonumentWork => remoteConfig.getString('Monument_Work_post_url');
  static String get postApiUrlRoadsWaterSupplyWork => remoteConfig.getString('Roads_Water_Supply_Work_post_url');
  static String get postApiUrlWaterSupplyBackFilling => remoteConfig.getString('Water_Supply_Back_Filling_post_url');
  static String get postApiUrlRoadsSignBoards => remoteConfig.getString('Roads_Sign_Boards_post_url');
  static String get postApiUrlRoadCurbStone => remoteConfig.getString('Road_Curb_Stone_post_url');
  static String get postApiUrlStreetRoadWaterChannels => remoteConfig.getString('Street_Road_Water_Channels_post_url');
  static String get postApiUrlMainGateCanopyColumnPouringWork => remoteConfig.getString('Main_Gate_Canopy_Column_Pouring_Work_post_url');
  static String get postApiUrlFoundationWorkMainGate => remoteConfig.getString('Foundation_Work_Main_Gate_post_url');
  static String get postApiUrlPillarsBrickWorkMainGate => remoteConfig.getString('Pillars_Brick_Work_Main_Gate_post_url');
  static String get postApiUrlGreyStructureMainGate => remoteConfig.getString('Grey_Structure_Main_Gate_post_url');
  static String get postApiUrlPlasterWorkMainGate => remoteConfig.getString('Plaster_Work_Main_Gate_post_url');


  }

