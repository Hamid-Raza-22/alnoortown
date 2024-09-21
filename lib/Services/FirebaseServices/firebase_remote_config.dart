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

