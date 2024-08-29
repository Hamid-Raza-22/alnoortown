import 'package:flutter/material.dart';
import 'Fountain Park/BoundaryGril/boundary_gril_work.dart';

import 'Fountain Park/CurbstonesWork/road_curbstones_work.dart';
import 'Fountain Park/GazeboWork/gazebo_work.dart';
import 'Fountain Park/MainEntranceTilesWork/main_entrance_tiles.dart';
import 'Fountain Park/MainStage/main_stage_work.dart';
import 'Fountain Park/MudFilling/mud_filling_work.dart';
import 'Fountain Park/PlantationWork/plantationwork.dart';
import 'Fountain Park/SittingAreaWork/sittingareawork.dart';
import 'Fountain Park/WalkingTracksWork/walking_tracks_work.dart';
import 'Mini Park/Curbstones Work MiniPark/Curbstones_minipark.dart';
import 'Mini Park/Fancy Light Poles/FancyLightPoles.dart';
import 'Mini Park/Grass Work/grasswork.dart';
import 'Mini Park/Mini Park Mud Filling/MP_Mud_Filling.dart';
import 'Mini Park/Monumentswork/MonumentsWork.dart';
import 'Mini Park/PlantationWorkMiniPark/minipark_plantation.dart';
import 'Mosque/CeilingWork/ceiling_work.dart';
import 'Mosque/DoorsWork/doors_work.dart';
import 'Mosque/ElectricityWork/electricity_work.dart';
import 'Mosque/FirstFloorWork/first_floor.dart';
import 'Mosque/FoundationWork/foundation_work.dart';
import 'Mosque/MosqueExcavationWork/mosque_excavation_work.dart';
import 'Mosque/PaintWork/paint_work.dart';
import 'Mosque/SanitaryWork/sanitory_work.dart';
import 'Mosque/TilesWork/tiles_work.dart';
import 'Road Sign Board/Road Sign Board.dart';
import 'Roads Compaction Work/BaseSubBaseCompaction/BaseSubBaseCompaction.dart';
import 'Roads Compaction Work/CompactionAfterWaterBound/CompactionAfterWaterBound.dart';
import 'Roads Compaction Work/SandCompaction/SandCompaction.dart';
import 'Roads Compaction Work/SoilCompaction/SoilCompaction.dart';
import 'Roads Edging/RoadsEdgingWork.dart';
import 'Roads Water Supply/Water Supply Backfiling/BackfillingWs.dart';
import 'Roads Water Supply/Water Supply/RoadsWaterSupplyWork.dart';
import 'RoadsCurbstonesWork/RoadsCurbstonesWork2.dart';
import 'RoadsShouldersWork/RoadsShouldersWork.dart';
import 'Street Roads Water Channels/StreetRoadsWaterChannels.dart';
import 'Town Main Gate/Canopy Coloumn Pouring/Canopy_coloumn_pouring.dart';
import 'Town Main Gate/Main Gate Foundation/MainGateFoundation.dart';
import 'Town Main Gate/Main Gate Grey Structure/MainGateGreyStructure.dart';
import 'Town Main Gate/Main Gate Pillars Brick/MainGatePillarsbrick.dart';
import 'Town Main Gate/Main Gate Plaster/Main_Gate_Plaster_Work.dart';


class Building_Navigation_Page extends StatefulWidget {
  const Building_Navigation_Page({super.key});

  @override
  State<Building_Navigation_Page> createState() =>
      _Building_Navigation_PageState();
}

class _Building_Navigation_PageState extends State<Building_Navigation_Page> {
  double screenHeight = 0;
  double screenWidth = 0;
  bool startAnimation = false;

  List<String> texts = [
    "Mosque",
    "Fountain Park",
    "Mini Parks",
    "Roads Compaction Work",
    "Roads Edging Work",
    "Roads Shoulders Work",
    "Roads Water Supply Work",
    "Roads Sign Boards",
    "Roads Curbstones Work",
    "Street Roads Water Channels",
    "Town Main Gates",
  ];

  List<String> imagePaths = [
    "assets/images/road_maintenance.png",
    "assets/images/sewerage_work.png",
    "assets/images/light_poles_work.png",
    "assets/images/maindrain_work.png",
    "assets/images/road_maintenance.png",
    "assets/images/sewerage_work.png",
    "assets/images/light_poles_work.png",
    "assets/images/maindrain_work.png",
    "assets/images/road_maintenance.png",
    "assets/images/sewerage_work.png",
    "assets/images/light_poles_work.png",
    "assets/images/maindrain_work.png",
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Building Work",
          style: TextStyle(
            color: Color(0xFFC69840),
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 20,
                ),
                child: Column(
                  children: [
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: texts.length,
                      itemBuilder: (context, index) {
                        return item(index);
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(int index) {
    return GestureDetector(
      onTap: () {
        if (texts[index] == "Mosque" ||
            texts[index] == "Fountain Park" ||
            texts[index] == "Mini Parks" ||
            texts[index] == "Roads Compaction Work" ||
            texts[index] == "Roads Water Supply Work" ||
            texts[index] == "Town Main Gates") {
          showAlertBox(index);
        } else {
          navigateToWorkPage(texts[index]);
        }
      },
      child: AnimatedContainer(
        height: 55,
        width: screenWidth,
        curve: Curves.linear,
        duration: Duration(milliseconds: 300 + (index * 200)),
        transform:
        Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
        margin: const EdgeInsets.only(
          bottom: 8,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 30,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                imagePaths[index],
                height: 35,
                width: 35,
              ),
            ),
            Container(
              width: 0.7,
              height: 60,
              color: Colors.grey.withOpacity(0.3),
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  texts[index],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFC69840),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlertBox(int index) {
    List<String> mosqueNames = [
      "Excavation Work",
      "Foundation Work",
      "First Floor",
      "Tiles Work",
      "Sanitary Work",
      "Ceiling Work",
      "Paint Work",
      "Electricity Work",
      "Doors Work"
    ];

    List<IconData> mosqueIcons = [
      Icons.construction, // Excavation Work
      Icons.foundation, // Foundation Work
      Icons.account_balance, // First Floor
      Icons.grid_on, // Tiles Work
      Icons.plumbing, // Sanitary Work
      Icons.roofing, // Ceiling Work
      Icons.format_paint, // Paint Work
      Icons.electrical_services, // Electricity Work
      Icons.door_front_door, // Doors Work
    ];

    List<String> fountainParkNames = [
      "Mud Filling Work",
      "Walking Tracks Work",
      "Cubstones Work",
      "Sitting Area Work",
      "Plantation Work",
      "Main Entrance Tiles Work",
      "Boundary Grill Work",
      "Gazebo Work",
      "Main Stage"
    ];

    List<IconData> fountainParkIcons = [
      Icons.landscape, // Mud Filling Work
      Icons.directions_walk, // Walking Tracks Work
      Icons.satellite, // Cubstones Work
      Icons.event_seat, // Sitting Area Work
      Icons.local_florist, // Plantation Work
      Icons.crop_square, // Main Entrance Tiles Work
      Icons.security, // Boundary Grill Work
      Icons.park, // Gazebo Work
      Icons.theater_comedy, // Main Stage
    ];

    List<String> miniParksNames = [
      "Mini Park Mud Filling",
      "Grass Work",
      "Mini Park Curbstones Work",
      "Fancy Light Poles",
      "Plantation Work mp",
      "Monuments Work",
    ];

    List<IconData> miniParksIcons = [
      Icons.landscape, // Mud Filling Work
      Icons.grass, // Grass Work
      Icons.satellite, // Curbstones Work
      Icons.lightbulb, // Fancy Light
      Icons.lightbulb, // Fancy Light Poles
      Icons.local_florist, // Plantation Work mp
      Icons.account_balance, // Monuments Work
    ];

    List<String> roadsCompactionNames = [
      "Sand Compaction",
      "Soil Compaction",
      "Base & Sub base compaction",
      "Compaction after Water Bound"
    ];

    List<IconData> roadsCompactionIcons = [
      Icons.terrain_sharp,
      Icons.terrain,
      Icons.layers,
      Icons.water_damage,
    ];

    List<String> roadsWaterSupplyNames = [
      "watersfirst",
      "backfillingWs",
    ];

    List<IconData> roadsWaterSupplyIcons = [
      Icons.water,
      Icons.backup,
    ];

    List<String> townMainGatesNames = [
      "Main Gate Foundation Work",
      "Main Gate Pillars Brick Work",
      "Main Gate Canopy & Column Pouring Work",
      "Main Gate Grey Structure",
      "Main Gate Plaster Work"
    ];

    List<IconData> townMainGatesIcons = [
      Icons.home_work,
      Icons.stop,
      Icons.wifi_tethering,
      Icons.home,
      Icons.format_paint,
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(texts[index]),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: (texts[index] == "Mosque")
                  ? mosqueNames.length
                  : (texts[index] == "Fountain Park")
                  ? fountainParkNames.length
                  : (texts[index] == "Mini Parks")
                  ? miniParksNames.length
                  : (texts[index] == "Roads Compaction Work")
                  ? roadsCompactionNames.length
                  : (texts[index] == "Roads Water Supply Work")
                  ? roadsWaterSupplyNames.length
                  : townMainGatesNames.length,
              itemBuilder: (context, subIndex) {
                return ListTile(
                  leading: Icon(
                    (texts[index] == "Mosque")
                        ? mosqueIcons[subIndex]
                        : (texts[index] == "Fountain Park")
                        ? fountainParkIcons[subIndex]
                        : (texts[index] == "Mini Parks")
                        ? miniParksIcons[subIndex]
                        : (texts[index] == "Roads Compaction Work")
                        ? roadsCompactionIcons[subIndex]
                        : (texts[index] == "Roads Water Supply Work")
                        ? roadsWaterSupplyIcons[subIndex]
                        : townMainGatesIcons[subIndex],
                  ),
                  title: Text(
                    (texts[index] == "Mosque")
                        ? mosqueNames[subIndex]
                        : (texts[index] == "Fountain Park")
                        ? fountainParkNames[subIndex]
                        : (texts[index] == "Mini Parks")
                        ? miniParksNames[subIndex]
                        : (texts[index] == "Roads Compaction Work")
                        ? roadsCompactionNames[subIndex]
                        : (texts[index] == "Roads Water Supply Work")
                        ? roadsWaterSupplyNames[subIndex]
                        : townMainGatesNames[subIndex],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    navigateToSubPage(texts[index], subIndex);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void navigateToWorkPage(String workType) {
    switch (workType) {
      case "Roads Edging Work":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RoadsEdgingWork()),
        );
        break;
      case "Roads Shoulders Work":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RoadsShouldersWork()),
        );
        break;
      case "Roads Sign Boards":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RoadsSignBoards()),
        );
        break;
      case "Roads Curbstones Work":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RoadsCurbstonesWork()),
        );
        break;
      case "Street Roads Water Channels":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StreetRoadsWaterChannels()),
        );
        break;
      default:
        break;
    }
  }

  void navigateToSubPage(String workType, int subIndex) {
    switch (workType) {
      case "Mosque":
        switch (subIndex) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MosqueExcavationWork()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FoundationWork()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FirstFloorWork()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TilesWork()),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SanitaryWork()),
            );
            break;
          case 5:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CeilingWork()),
            );
            break;
          case 6:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaintWork()),
            );
            break;
          case 7:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ElectricityWork()),
            );
            break;
          case 8:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DoorsWork()),
            );
            break;
        }
        break;
      case "Fountain Park":
        switch (subIndex) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MudFillingWork()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WalkingTracksWork()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CurbStonesWork()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SittingAreaWork()),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlantationWork()),
            );
            break;
          case 5:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainEntranceTilesWork()),
            );
            break;
          case 6:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BoundaryGrillWork()),
            );
            break;
          case 7:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GazeboWork()),
            );
            break;
          case 8:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainStageWork()),
            );
            break;
        }
        break;
      case "Mini Parks":
        switch (subIndex) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MiniParkMudFilling()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GrassWork()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MiniParkCurbstonesWork()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FancyLightPoles()),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PlantationWorkmp()),
            );
            break;
          case 5:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MonumentsWork()),
            );
            break;
        }
        break;
      case "Roads Compaction Work":
        switch (subIndex) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SandCompaction()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SoilCompaction()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BaseSubBase()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CompactionAfterWaterBound()),
            );
            break;
        }
        break;
      case "Roads Water Supply Work":
        switch (subIndex) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RoadsWaterSupplyWork()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BackfillingWs()),
            );
            break;
        }
        break;
      case "Town Main Gates":
        switch (subIndex) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainGateFoundationWork()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainGatePillarsBrickWork()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  const CanopyColoumnPouring()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainGateGreyStructure()),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainGatePlasterWork()),
            );
            break;
        }
        break;
    }
  }
}