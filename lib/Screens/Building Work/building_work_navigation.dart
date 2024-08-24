import 'package:al_noor_town/Screens/Building%20Work/Fountain%20Park/CubstonesWork/road_curbstones_work.dart';
import 'package:flutter/material.dart';
import '../Roads Compaction Work/BaseSubBaseCompaction.dart';
import '../Roads Compaction Work/CompactionAfterWaterBound.dart';
import '../Roads Compaction Work/SandCompaction.dart';
import '../Roads Compaction Work/SoilCompaction.dart';
import 'Fountain Park/BoundaryGril/boundary_gril_work.dart';
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
import 'Mosque/MosqueExavationWork/mosque_exavation_work.dart';
import 'Mosque/PaintWork/paint_work.dart';
import 'Mosque/SanitaryWork/sanitory_work.dart';
import 'Mosque/TilesWork/tiles_work.dart';


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
        showAlertBox(index);
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
      Icons.lightbulb, // Fancy Light Poles
      Icons.local_florist, // Plantation Work
      Icons.emoji_objects, // Monuments Work
    ];

    List<String> roadsCompactionNames = [
      "Sand Compaction",
      "Soil Compaction",
      "Base & Sub base compaction",
      "Compaction after Water Bound",
    ];

    List<IconData> roadsCompactionIcons = [
      Icons.note_sharp, // Sand Compaction
      Icons.terrain, // Soil Compaction
      Icons.layers, // Base & Sub base compaction
      Icons.water_damage, // Compaction after Water Bound
    ];

    if (texts[index] == "Mosque") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              "Mosque Work",
              style: TextStyle(color: Color(0xFFC69840)),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: mosqueNames.length,
                itemBuilder: (context, mosqueIndex) {
                  return ListTile(
                    leading: Icon(mosqueIcons[mosqueIndex],
                        color: const Color(0xFFC69840)),
                    title: Text(mosqueNames[mosqueIndex]),
                    onTap: () {
                      // Navigate to the corresponding page
                      Navigator.of(context).pop();
                      if (mosqueIndex == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MosqueExavationWork()),
                        );
                      } else if (mosqueIndex == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FoundationWork()),
                        );
                      } else if (mosqueIndex == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FirstFloorWork()),
                        );
                      } else if (mosqueIndex == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TilesWork()),
                        );
                      } else if (mosqueIndex == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SanitaryWork()),
                        );
                      } else if (mosqueIndex == 5) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CeilingWork()),
                        );
                      } else if (mosqueIndex == 6) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaintWork()),
                        );
                      } else if (mosqueIndex == 7) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ElectricityWork()),
                        );
                      } else if (mosqueIndex == 8) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DoorsWork()),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    } else if (texts[index] == "Fountain Park") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              "Fountain Park Work",
              style: TextStyle(color: Color(0xFFC69840)),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: fountainParkNames.length,
                itemBuilder: (context, fountainParkIndex) {
                  return ListTile(
                    leading: Icon(fountainParkIcons[fountainParkIndex],
                        color: const Color(0xFFC69840)),
                    title: Text(fountainParkNames[fountainParkIndex]),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (fountainParkIndex == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MudFillingWork()),
                        );
                      } else if (fountainParkIndex == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WalkingTracksWork()),
                        );
                      } else if (fountainParkIndex == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CubstonesWork()),
                        );
                      } else if (fountainParkIndex == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SittingAreaWork()),
                        );
                      } else if (fountainParkIndex == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlantationWork()),
                        );
                      } else if (fountainParkIndex == 5) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainEntranceTilesWork()),
                        );
                      } else if (fountainParkIndex == 6) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BoundaryGrillWork()),
                        );
                      } else if (fountainParkIndex == 7) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GazeboWork()),
                        );
                      } else if (fountainParkIndex == 8) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainStageWork()),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    } else if (texts[index] == "Mini Parks") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              "Mini Parks Work",
              style: TextStyle(color: Color(0xFFC69840)),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: miniParksNames.length,
                itemBuilder: (context, miniParksIndex) {
                  return ListTile(
                    leading: Icon(miniParksIcons[miniParksIndex],
                        color: const Color(0xFFC69840)),
                    title: Text(miniParksNames[miniParksIndex]),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (miniParksIndex == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MiniParkMudFilling()),
                        );
                      } else if (miniParksIndex == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GrassWork()),
                        );
                      } else if (miniParksIndex == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MiniParkCurbstonesWork()),
                        );
                      } else if (miniParksIndex == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FancyLightPoles()),
                        );
                      } else if (miniParksIndex == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlantationWorkmp()),
                        );
                      } else if (miniParksIndex == 5) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MonumentsWork()),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    } else if (texts[index] == "Roads Compaction Work") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              "Roads Compaction",
              style: TextStyle(color: Color(0xFFC69840)),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: roadsCompactionNames.length,
                itemBuilder: (context, roadsCompactionIndex) {
                  return ListTile(
                    leading: Icon(roadsCompactionIcons[roadsCompactionIndex],
                        color: const Color(0xFFC69840)),
                    title: Text(roadsCompactionNames[roadsCompactionIndex]),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (roadsCompactionIndex == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SandCompaction()),
                        );
                      } else if (roadsCompactionIndex == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SoilCompaction()),
                        );
                      } else if (roadsCompactionIndex == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BaseSubBaseCompaction()),
                        );
                      } else if (roadsCompactionIndex == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CompactionAfterWaterBound()),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }
}
