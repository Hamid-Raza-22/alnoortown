import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/BoundaryWallViewModel/PillarsViewModel/pillars_fixing_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/BoundaryWallViewModel/PillarsViewModel/pillars_removal_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/BoundaryWallViewModel/PlanksViewModel/planks_fixing_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/BoundaryWallViewModel/PlanksViewModel/planks_removal_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/RoadMaintenaceViewModel/machine_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/boundary_grill_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/cubStones_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/gazebo_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/main_entrance_tiles_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/main_stage_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/mud_filling_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/plantation_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/sitting_area_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/walking_tracks_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/grass_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/mini_park_curb_stone_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/mini_park_mud_filling_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/monuments_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/mp_fancy_light_poles_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/mp_plantation_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/ceiling_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/door_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/electricity_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/first_floor_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/foundation_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/mosque_excavation_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/paint_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/sanitary_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/tiles_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/base_sub_base_compaction_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/compaction_water_bound_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/sand_compaction_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/soil_compaction_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCurbstonesWorkViewModel/road_curb_stones_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsEdgingWorksViewModel/roads_edging_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsShouldersWorkViewModel/roads_shoulder_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsSignBoardsViewModel/roads_sign_boards_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsWaterSupplyWorkViewModel/back_filling_ws_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsWaterSupplyWorkViewModel/roads_water_supply_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/StreetRoadwaterChannelViewModel/street_road_water_channel_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/TownMainGatesViewModel/canopy_column_pouring_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/TownMainGatesViewModel/main_gate_foundation_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/TownMainGatesViewModel/main_gate_pillar_work_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/TownMainGatesViewModel/mg_grey_structure_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/TownMainGatesViewModel/mg_plaster_work_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/LightPolesWorkViewModel/light_wires_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/LightPolesWorkViewModel/poles_excavation_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/LightPolesWorkViewModel/poles_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/asphalt_work_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/brick_work_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/iron_work_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/main_drain_excavation_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/man_holes_slab_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/plaster_work_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/shuttering_work_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/RoadMaintenaceViewModel/machine_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/RoadMaintenaceViewModel/water_tanker_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/SewerageWorksViewModel/back_filling_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/SewerageWorksViewModel/excavation_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/SewerageWorksViewModel/manholes_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/SewerageWorksViewModel/pipeline_view_model.dart';
import 'package:al_noor_town/ViewModels/LoginViewModel/login_view_model.dart';
import 'package:al_noor_town/ViewModels/MaterialShiftingViewModel/material_shifting_view_model.dart';
import 'package:al_noor_town/ViewModels/NewMaterialViewModel/new_material_view_model.dart';
import 'package:al_noor_town/ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, SnackPosition;
import 'package:http/http.dart' as http;
import 'package:al_noor_town/Screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:internet_speed_test/callbacks_enum.dart';
// import 'package:internet_speed_test/internet_speed_test.dart';

import '../ViewModels/AttendanceViewModel/attendance_in_view_model.dart';
import '../ViewModels/AttendanceViewModel/attendance_out_view_model.dart';
import '../ViewModels/DevelopmentWorksViewModel/LightPolesWorkViewModel/poles_foundation_view_model.dart';
import '../main.dart';
import 'home_page.dart';

import '../ViewModels/AttendanceViewModel/attendance_in_view_model.dart';
import '../ViewModels/AttendanceViewModel/attendance_out_view_model.dart';

class LoginPage extends StatefulWidget {
    LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginViewModel loginViewModel =Get.put(LoginViewModel());
  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());
  BlockDetailsViewModel blockDetailsViewModel = Get.put(BlockDetailsViewModel());
  MachineViewModel machineViewModel = Get.put(MachineViewModel());
  WaterTankerViewModel waterTankerViewModel = Get.put(WaterTankerViewModel());
  ExcavationViewModel excavationViewModel = Get.put(ExcavationViewModel());
  BackFillingViewModel backFillingViewModel = Get.put(BackFillingViewModel());
  ManholesViewModel manholesViewModel = Get.put(ManholesViewModel());
  PipelineViewModel pipelineViewModel = Get.put(PipelineViewModel());
  PolesExcavationViewModel polesExcavationViewModel = Get.put(PolesExcavationViewModel());
  PolesFoundationViewModel polesFoundationViewModel = Get.put(PolesFoundationViewModel());
  PolesViewModel polesViewModel = Get.put(PolesViewModel());
  LightWiresViewModel lightWiresViewModel = Get.put(LightWiresViewModel());
  IronWorkViewModel ironWorkViewModel = Get.put(IronWorkViewModel());
  ManHolesSlabViewModel manHolesSlabViewModel = Get.put(ManHolesSlabViewModel());
  AsphaltWorkViewModel asphaltWorkViewModel = Get.put(AsphaltWorkViewModel());
  MainDrainExcavationViewModel mainDrainExcavationViewModel = Get.put(MainDrainExcavationViewModel());
  BrickWorkViewModel brickWorkViewModel = Get.put(BrickWorkViewModel());
  PlasterWorkViewModel plasterWorkViewModel = Get.put(PlasterWorkViewModel());
  ShutteringWorkViewModel shutteringWorkViewModel = Get.put(ShutteringWorkViewModel());
  MaterialShiftingViewModel materialShiftingViewModel = Get.put(MaterialShiftingViewModel());
  NewMaterialViewModel newMaterialViewModel = Get.put(NewMaterialViewModel());
  MosqueExcavationViewModel mosqueExcavationViewModel = Get.put(MosqueExcavationViewModel());
  FoundationWorkViewModel foundationWorkViewModel = Get.put(FoundationWorkViewModel());
  FirstFloorViewModel firstFloorViewModel = Get.put(FirstFloorViewModel());
  TilesWorkViewModel tilesWorkViewModel = Get.put(TilesWorkViewModel());
  SanitaryWorkViewModel sanitaryWorkViewModel = Get.put(SanitaryWorkViewModel());
  CeilingWorkViewModel ceilingWorkViewModel = Get.put(CeilingWorkViewModel());
  PaintWorkViewModel paintWorkViewModel = Get.put(PaintWorkViewModel());
  ElectricityWorkViewModel electricityWorkViewModel = Get.put(ElectricityWorkViewModel());
  DoorWorkViewModel doorWorkViewModel = Get.put(DoorWorkViewModel());
  MudFillingWorkViewModel mudFillingWorkViewModel = Get.put(MudFillingWorkViewModel());
  WalkingTracksWorkViewModel walkingTracksWorkViewModel = Get.put(WalkingTracksWorkViewModel());
  CubStonesWorkViewModel cubStonesWorkViewModel = Get.put(CubStonesWorkViewModel());
  SittingAreaWorkViewModel sittingAreaWorkViewModel = Get.put(SittingAreaWorkViewModel());
  PlantationWorkViewModel plantationWorkViewModel = Get.put(PlantationWorkViewModel());
  MainEntranceTilesWorkViewModel mainEntranceTilesWorkViewModel = Get.put(MainEntranceTilesWorkViewModel());
  BoundaryGrillWorkViewModel boundaryGrillWorkViewModel = Get.put(BoundaryGrillWorkViewModel());
  GazeboWorkViewModel gazeboWorkViewModel = Get.put(GazeboWorkViewModel());
  MainStageWorkViewModel mainStageWorkViewModel = Get.put(MainStageWorkViewModel());
  MiniParkMudFillingViewModel miniParkMudFillingViewModel = Get.put(MiniParkMudFillingViewModel());
  GrassWorkViewModel grassWorkViewModel = Get.put(GrassWorkViewModel());
  MiniParkCurbStoneViewModel miniParkCurbStoneViewModel = Get.put(MiniParkCurbStoneViewModel());
  MpFancyLightPolesViewModel mpFancyLightPolesViewModel = Get.put(MpFancyLightPolesViewModel());
  MpPlantationWorkViewModel mpPlantationWorkViewModel = Get.put(MpPlantationWorkViewModel());
  MonumentsWorkViewModel monumentsWorkViewModel = Get.put(MonumentsWorkViewModel());
  SandCompactionViewModel sandCompactionViewModel = Get.put(SandCompactionViewModel());
  SoilCompactionViewModel soilCompactionViewModel = Get.put(SoilCompactionViewModel());
  BaseSubBaseCompactionViewModel baseSubBaseCompactionViewModel = Get.put(BaseSubBaseCompactionViewModel());
  CompactionWaterBoundViewModel compactionWaterBoundViewModel = Get.put(CompactionWaterBoundViewModel());
  RoadsEdgingWorkViewModel roadsEdgingWorkViewModel = Get.put(RoadsEdgingWorkViewModel());
  RoadsShoulderWorkViewModel roadsShoulderWorkViewModel = Get.put(RoadsShoulderWorkViewModel());
  RoadsWaterSupplyViewModel roadsWaterSupplyViewModel = Get.put(RoadsWaterSupplyViewModel());
  BackFillingWsViewModel backFillingWsViewModel = Get.put(BackFillingWsViewModel());
  RoadsSignBoardsViewModel roadsSignBoardsViewModel = Get.put(RoadsSignBoardsViewModel());
  RoadCurbStonesWorkViewModel roadCurbStonesWorkViewModel = Get.put(RoadCurbStonesWorkViewModel());
  StreetRoadWaterChannelViewModel streetRoadWaterChannelViewModel = Get.put(StreetRoadWaterChannelViewModel());
  MainGateFoundationWorkViewModel mainGateFoundationWorkViewModel = Get.put(MainGateFoundationWorkViewModel());
  MainGatePillarWorkViewModel mainGatePillarWorkViewModel = Get.put(MainGatePillarWorkViewModel());
  CanopyColumnPouringViewModel canopyColumnPouringViewModel = Get.put(CanopyColumnPouringViewModel());
  MgGreyStructureViewModel mgGreyStructureViewModel = Get.put(MgGreyStructureViewModel());
  MgPlasterWorkViewModel mgPlasterWorkViewModel = Get.put(MgPlasterWorkViewModel());
  AttendanceInViewModel attendanceInViewModel = Get.put(AttendanceInViewModel());
  AttendanceOutViewModel attendanceOutViewModel = Get.put(AttendanceOutViewModel());
  PillarsFixingViewModel pillarsFixingViewModel = Get.put(PillarsFixingViewModel());
  PillarsRemovalViewModel pillarsRemovalViewModel = Get.put(PillarsRemovalViewModel());
  PlanksFixingViewModel planksFixingViewModel =Get.put(PlanksFixingViewModel());
  PlanksRemovalViewModel planksRemovalViewModel = Get.put(PlanksRemovalViewModel());



  bool _obscureText = true;
  bool _isLoading = false;
  double _loadingPercentage = 0.0;

  String _loadingMessage = '';

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  bool _hasInternet = true;
  bool _isInternetLoading = true;

  @override
  void initState() {
    super.initState();
    _checkInternetBeforeNavigation();

  }
  // Method to check the internet connection before navigating to the login page
  Future<void> _checkInternetBeforeNavigation() async {
    bool hasInternet = await checkInternetConnection();

    if (!hasInternet) {
      setState(() {
        _hasInternet = false;
      });

      // Show a GetX Snackbar with an internet error message
      Get.snackbar(
        'Internet Error',
        'No internet connection. The app will close shortly.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );

      // Delay for a few seconds before closing the app to allow user to see the message
      await Future.delayed(Duration(seconds: 5));
      exit(0); // Close the app if no internet connection
    } else {
     await loginViewModel.fetchAndSaveLoginData();
      setState(() {
        _hasInternet = true;
        _isInternetLoading = false;
      });
    }
  }



  final storage =   const FlutterSecureStorage();

  // void _loginwithJWT() async {
  //   String email = _emailController.text.trim();
  //   String password = _passwordController.text.trim();
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://your-backend-url.com/login'), // Replace with your backend login URL
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'email': email, 'password': password}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Assuming the JWT is in the response body as 'token'
  //       final data = jsonDecode(response.body);
  //       String token = data['token'];
  //
  //       // Store the JWT securely
  //       await storage.write(key: 'jwt', value: token);
  //
  //       // Navigate to the HomePage
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) =>   HomePage()),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //          SnackBar(content: Text('Login failed. Please try again.'.tr())),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('An error occurred: $e')),
  //     );
  //   }
  // }
  // void _fetchUserData() async {
  //   final String? token = await storage.read(key: 'jwt');
  //   final response = await http.get(
  //     Uri.parse('https://your-backend-url.com/user-profile'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // Handle the successful response here
  //     // e.g., parse the JSON and update the UI
  //   } else {
  //     // Handle error here
  //   }
  // }

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;  // Start loading
      _loadingMessage = 'Checking internet connection...';  // Initial message
    });

    // Introduce a delay of 20 seconds
    bool isConnected = false;
    for (int i = 0; i < 20; i++) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        // Check if internet is actually working
        try {
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            isConnected = true;
            break;
          }
        } catch (_) {
          // Internet is not working
        }
      }
      await Future.delayed(Duration(seconds: 1));
    }

    if (!isConnected) {
      setState(() {
        _isLoading = false;
        _loadingMessage = '';
      });
      Get.snackbar('Error', 'No internet connection', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    setState(() {
      _loadingMessage = 'Checking internet speed...';  // Update message
    });

    // final internetSpeedTest = InternetSpeedTest();
    // double downloadSpeed = 0.0;
    //
    // await internetSpeedTest.startDownloadTesting(
    //   onProgress: (double percent, double transferRate, SpeedUnit unit) {
    //     // You can update the UI with the progress if needed
    //   },
    //   onDone: (double transferRate, SpeedUnit unit) {
    //     downloadSpeed = transferRate;
    //   },
    //   onError: (String errorMessage, String speedTestError) {
    //     setState(() {
    //       _isLoading = false;
    //       _loadingMessage = '';
    //     });
    //     Get.snackbar('Error', 'Internet speed test failed', snackPosition: SnackPosition.BOTTOM);
    //     return;
    //   },
    // );
    //
    // if (downloadSpeed < 5.0) {  // Assuming 5 Mbps as the threshold for good speed
    //   setState(() {
    //     _isLoading = false;
    //     _loadingMessage = '';
    //   });
    //   Get.snackbar('Error', 'Internet speed is too slow', snackPosition: SnackPosition.BOTTOM);
    //   return;
    // }

    setState(() {
      _loadingMessage = 'Logging in...';  // Update message
    });


    await prefs.setString('userId', _emailController.text.trim());
     userId = prefs.getString('userId')!;
// Get the entered user ID
    bool success = await loginViewModel.login(
      _emailController.text,
      _passwordController.text,
    );

    if (success) {
      setState(() {
        _loadingMessage = 'Fetching Block details...'; // Update message
      });
      await blockDetailsViewModel.fetchAndSaveBlockDetailsData();

      setState(() {
        _loadingMessage = 'Fetching Road details...'; // Update message
      });
      await roadDetailsViewModel.fetchAndSaveRoadDetailsData();
      setState(() {
        _loadingMessage = 'Machines details...'; // Update message
      });
      await machineViewModel.fetchAndSaveMachineData();

      setState(() {
        _loadingMessage = 'Fetching WaterTanker details...'; // Update message
      });
      await waterTankerViewModel.fetchAndSaveTankerData();


      setState(() {
        _loadingMessage = 'Fetching Excavation details...'; // Update message
      });
      await excavationViewModel.fetchAndSaveExcavationData();

      setState(() {
        _loadingMessage = 'Fetching BackFilling details...'; // Update message
      });
      await backFillingViewModel.fetchAndSaveBackFillingData();
      setState(() {
        _loadingMessage = 'Fetching Manholes details...'; // Update message
      });
      await manholesViewModel.fetchAndSaveManholesData();
      setState(() {
        _loadingMessage = 'Fetching Pipeline details...'; // Update message
      });
       await pipelineViewModel.fetchAndSavePipeLineData();
      setState(() {
        _loadingMessage =
        'Fetching Poles Excavation details...'; // Update message
      });
      await polesExcavationViewModel.fetchAndSavePolesExcavationData();
      setState(() {
        _loadingMessage =
        'Fetching Poles Foundation details...'; // Update message
      });
      await polesFoundationViewModel.fetchAndSavePolesFoundationData();
      setState(() {
        _loadingMessage = 'Fetching Poles details...'; // Update message
      });
      await polesViewModel.fetchAndSavePolesData();
      setState(() {
        _loadingMessage = 'Fetching LightWires details...'; // Update message
      });
      await lightWiresViewModel.fetchAndSaveLightWiresData();
      setState(() {
        _loadingMessage = 'Fetching IronWork details...'; // Update message
      });
      await ironWorkViewModel.fetchAndSaveIronWorksData();
      setState(() {
        _loadingMessage = 'Fetching ManHoles Slab details...'; // Update message
      });
      await manHolesSlabViewModel.fetchAndSaveManHolesData();
      setState(() {
        _loadingMessage = 'Fetching Asphalt details...'; // Update message
      });
      await asphaltWorkViewModel.fetchAndSaveAsphaltWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Drain Excavation details...'; // Update message
      });
      await mainDrainExcavationViewModel.fetchAndSaveMainDrainExcavationData();
      setState(() {
        _loadingMessage = 'Fetching Brick Work details...'; // Update message
      });
      await brickWorkViewModel.fetchAndSaveBrickWorkData();
      setState(() {
        _loadingMessage = 'Fetching Plaster Work details...'; // Update message
      });
      await plasterWorkViewModel.fetchAndSavePlasterWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Shuttering Work details...'; // Update message
      });
      //  await shutteringWorkViewModel.fetchAndSaveShutteringWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Mosque Excavation details...'; // Update message
      });
      await mosqueExcavationViewModel.fetchAndSaveMosqueExcavationData();
      setState(() {
        _loadingMessage =
        'Fetching Mosque Foundation details...'; // Update message
      });
      await foundationWorkViewModel.fetchAndSaveFoundationWorkData();
      setState(() {
        _loadingMessage = 'Fetching First Floor details...'; // Update message
      });
      await firstFloorViewModel.fetchAndSaveFirstFloorData();
      setState(() {
        _loadingMessage = 'Fetching Tiles Work details...'; // Update message
      });
      await tilesWorkViewModel.fetchAndSaveTilesWorkData();
      setState(() {
        _loadingMessage = 'Fetching Sanitary Work details...'; // Update message
      });
      await sanitaryWorkViewModel.fetchAndSaveSanitaryWorkData();
      setState(() {
        _loadingMessage = 'Fetching Ceiling Work details...'; // Update message
      });
      await ceilingWorkViewModel.fetchAndSaveCeilingWorkData();
      setState(() {
        _loadingMessage = 'Fetching Paint Work details...'; // Update message
      });

      await paintWorkViewModel.fetchAndSavePaintWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Electricity work details...'; // Update message
      });
      await electricityWorkViewModel.fetchAndSaveElectricityWorkData();
      setState(() {
        _loadingMessage = 'Fetching Doors Work details...'; // Update message
      });
      await doorWorkViewModel.fetchAndSaveDoorWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Mud Filling Work details...'; // Update message
      });
      await mudFillingWorkViewModel.fetchAndSaveMudFillingWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Walking Tracks details...'; // Update message
      });
      await walkingTracksWorkViewModel.fetchAndSaveWalkingTracksWorksData();
      setState(() {
        _loadingMessage =
        'Fetching CurbStone Work details...'; // Update message
      });
      await cubStonesWorkViewModel.fetchAndSaveCurbStoneWorkData();
      setState(() {
        _loadingMessage = 'Fetching Sitting Area details...'; // Update message
      });
      await sittingAreaWorkViewModel.fetchAndSaveSittingAreaData();
      setState(() {
        _loadingMessage = 'Fetching Plantation details...'; // Update message
      });
      await plantationWorkViewModel.fetchAndSavePlantationWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Main Entrance Tiles Work details...'; // Update message
      });
      await mainEntranceTilesWorkViewModel
          .fetchAndSaveMainEntranceTilesWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Boundary Grill Work details...'; // Update message
      });
      await boundaryGrillWorkViewModel.fetchAndSaveBoundaryGrillWorkData();
      setState(() {
        _loadingMessage = 'Fetching Gazebo Work details...'; // Update message
      });
      await gazeboWorkViewModel.fetchAndSaveGazeboData();
      setState(() {
        _loadingMessage = 'Fetching Main Stage details...'; // Update message
      });
      await mainStageWorkViewModel.fetchAndSaveMainStageWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Mini Park MudFilling details...'; // Update message
      });
      await miniParkMudFillingViewModel.fetchAndSaveMiniParkMudFillingData();
      setState(() {
        _loadingMessage = 'Fetching Grass Work details...'; // Update message
      });
      await grassWorkViewModel.fetchAndSaveGrassWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Mini Park CurbStone details...'; // Update message
      });
      await miniParkCurbStoneViewModel.fetchAndSaveMiniParkCurbStoneData();
      setState(() {
        _loadingMessage =
        'Fetching Fancy light Poles details...'; // Update message
      });
      await mpFancyLightPolesViewModel
          .fetchAndSaveMiniParkFancyLightPolesData();
      setState(() {
        _loadingMessage =
        'Fetching Plantation Work mini Park details...'; // Update message
      });
      await mpPlantationWorkViewModel.fetchAndSaveMiniParkPlantationData();
      setState(() {
        _loadingMessage = 'Fetching monument Work details...'; // Update message
      });
      await monumentsWorkViewModel.fetchAndSaveMonumentData();
      setState(() {
        _loadingMessage =
        'Fetching Sand Compaction details...'; // Update message
      });
      await sandCompactionViewModel.fetchAndSaveSandCompactionData();
      setState(() {
        _loadingMessage =
        'Fetching soil Compaction details...'; // Update message
      });
      await soilCompactionViewModel.fetchAndSaveSoilCompactionData();
      setState(() {
        _loadingMessage =
        'Fetching Base Sub Base Compaction details...'; // Update message
      });
      await baseSubBaseCompactionViewModel
          .fetchAndSaveBaseSubBaseCompactionData();
      setState(() {
        _loadingMessage =
        'Fetching Compaction After Water Bound details...'; // Update message
      });
      await compactionWaterBoundViewModel
          .fetchAndSaveCompactionWaterBoundData();
      setState(() {
        _loadingMessage = 'Fetching Roads Edging details...'; // Update message
      });
      await roadsEdgingWorkViewModel.fetchAndSaveRoadsEdgingWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Roads Shoulder details...'; // Update message
      });
      await roadsShoulderWorkViewModel.fetchAndSaveRoadsShoulderWorkData();
      setState(() {
        _loadingMessage =
        'Fetching Road Water Supply details...'; // Update message
      });
      await roadsWaterSupplyViewModel.fetchAndSaveRoadsWaterSupplyData()
      ;
      setState(() {
        _loadingMessage =
        'Fetching Water Supply Back Filling  details...'; // Update message
      });
      await backFillingWsViewModel.fetchAndSaveBackFillingData()
      ;
      setState(() {
        _loadingMessage =
        'Fetching RoadsSign Boards details...'; // Update message
      });
      await roadsSignBoardsViewModel.fetchAndSaveRoadsSignBoardsData()
      ;
      setState(() {
        _loadingMessage =
        'Fetching Road Curb Stone Work details...'; // Update message
      });
      await roadCurbStonesWorkViewModel.fetchAndSaveRoadsCurbStonesWorkData()
      ;
      setState(() {
        _loadingMessage =
        'Fetching Street Roads Water Channel details...'; // Update message
      });
      await streetRoadWaterChannelViewModel
          .fetchAndSaveStreetRoadsWaterChannelData()
      ;
      setState(() {
        _loadingMessage =
        'Fetching Main Gate Foundation Work details...'; // Update message
      });
      await mainGateFoundationWorkViewModel.fetchAndSaveMainGateFoundationData()
      ;
      setState(() {
        _loadingMessage =
        'Fetching Main Gate Pillars Brick Work details...'; // Update message
      });
      await mainGatePillarWorkViewModel.fetchAndSaveMainGatePillarData()
      ;
      setState(() {
        _loadingMessage =
        'Fetching Main Gate Canopy Column Pouring Work details...'; // Update message
      });
      await canopyColumnPouringViewModel.fetchAndSaveCanopyColumnData()
      ;
      setState(() {
        _loadingMessage =
        'Fetching Main Gate Gray Structure details...'; // Update message
      });
      await mgGreyStructureViewModel.fetchAndSaveMainGateGreyStructureData();
      setState(() {
        _loadingMessage =
        'Fetching Main Gate Plaster Work details...'; // Update message
      });
      await mgPlasterWorkViewModel.fetchAndSaveMainGatePlasterData();
      setState(() {
        _loadingMessage =
        'Fetching Pillars Fixing details...'; // Update message
      });
      await pillarsFixingViewModel.fetchAndSavePillarsFixingData();
      setState(() {
        _loadingMessage =
        'Fetching Pillars Removal details...'; // Update message
      });
      await pillarsRemovalViewModel.fetchAndSavePillarsRemovalData();
      setState(() {
        _loadingMessage =
        'Fetching Planks Fixing details...'; // Update message
      });
      await planksFixingViewModel.fetchAndSavePlanksFixingData();
      setState(() {
        _loadingMessage =
        'Fetching Planks Removal details...'; // Update message
      });
      await planksRemovalViewModel.fetchAndSavePlanksRemovalData();

      // Navigate to the next screen
      Future.delayed(Duration(milliseconds: 300), () {
        Get.offNamed('/home');
      });
    } else {
      Get.snackbar('Error', 'Invalid user ID or password', snackPosition: SnackPosition.BOTTOM);
    }

    setState(() {
      _isLoading = false;  // Stop loading
      _loadingMessage = '';  // Reset message
    });
  }






  //   void _login() async {
  // // context.setLocale(Locale('en')); // English set karne ke liye
  // //   String email = _emailController.text.trim();
  // //   String password = _passwordController.text.trim();
  //     await blockDetailsViewModel.fetchAndSaveBlockDetailsData();
  //     await roadDetailsViewModel.fetchAndSaveRoadDetailsData();
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) =>   HomePage()),
  //   );
  //
  //   // try {
  //   //   UserCredential userCredential = await FirebaseAuth.instance
  //   //       .signInWithEmailAndPassword(email: email, password: password);
  //   //
  //   //   // Login successful, navigate to the HomePage
  //   //   Navigator.pushReplacement(
  //   //     context,
  //   //     MaterialPageRoute(builder: (context) => HomePage()),
  //   //   );
  //   // } on FirebaseAuthException catch (e) {
  //   //   String errorMessage;
  //   //
  //   //   if (e.code == 'user-not-found'.tr()) {
  //   //     errorMessage = 'No user found for that email.'.tr();
  //   //   } else if (e.code == 'wrong-password') {
  //   //     errorMessage = 'Wrong password provided for that user.'.tr();
  //   //   } else {
  //   //     errorMessage = 'Login failed. Please try again later.'.tr();
  //   //   }
  //   //
  //   //   ScaffoldMessenger.of(context).showSnackBar(
  //   //     SnackBar(content: Text(errorMessage)),
  //   //   );
  //   // } catch (e) {
  //   //   ScaffoldMessenger.of(context).showSnackBar(
  //   //     SnackBar(content: Text('An unexpected error occurred: $e'.tr())),
  //   //   );
  //   // }
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image with blur effect
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/gate_view.png'),  // Path to your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blurring effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.3),  // Optional: Adjust overlay color and opacity
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: MediaQuery.of(context).size.width > 600
                    ? EdgeInsets.symmetric(horizontal: 50.0)
                    : EdgeInsets.all(30.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width > 600 ? 500 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'login'.tr(),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC69840),
                          ),
                        ),
                        SizedBox(height: 20),
                        FadeInUp(
                          duration: Duration(milliseconds: 1800),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xFFC69840)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Color(0xFFC69840)),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "user_id_hint".tr(),
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5)),
                                      labelText: "user_id".tr(),
                                      labelStyle: TextStyle(color: Color(0xFFC69840)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "password".tr(),
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5)),
                                      labelText: "password".tr(),
                                      labelStyle: TextStyle(color: Color(0xFFC69840)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Color(0xFFC69840),
                                        ),
                                        onPressed: _togglePasswordVisibility,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        FadeInUp(
                          duration: Duration(milliseconds: 1900),
                          child: GestureDetector(
                            onTap: _isLoading ? null : _login,  // Disable button when loading
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: _isLoading ? Colors.brown : Color(0xFFC69840),  // Change button color when loading
                              ),
                              child: Center(
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),  // Smooth transition duration
                                  child: _isLoading
                                      ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),  // Spinner color
                                        strokeWidth: 2.0,
                                      ),
                                      SizedBox(width: 10),  // Space between spinner and text
                                      Text(
                                        _loadingMessage,  // Dynamic loading message
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  )
                                      : Text(
                                    "login".tr(),  // Original login text
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),



                        // SizedBox(height: 20),
                        // FadeInUp(
                        //   duration: Duration(milliseconds: 2000),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => SignUpPage()),
                        //       );
                        //     },
                        //     child: Text(
                        //       "dont_have_an_account".tr(),
                        //       style: TextStyle(
                        //         color: Color(0xFFC69840),
                        //         fontWeight: FontWeight.bold,
                        //         decoration: TextDecoration.underline,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}