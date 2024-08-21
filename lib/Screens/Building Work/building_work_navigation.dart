import 'package:flutter/material.dart';
import 'Mosque/ceiling_work.dart';
import 'Mosque/doors_work.dart';
import 'Mosque/electricity_work.dart';
import 'Mosque/first_floor.dart';
import 'Mosque/foundation_work.dart';
import 'Mosque/mosque_exavation_work.dart';
import 'Mosque/paint_work.dart';
import 'Mosque/sanitory_work.dart';
import 'Mosque/tiles_work.dart';

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
          icon: Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
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

    if (texts[index] == "Mosque") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              texts[index],
              style: TextStyle(
                color: Color(0xFFC69840),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: mosqueNames.asMap().entries.map((entry) {
                int idx = entry.key;
                String name = entry.value;
                return ListTile(
                  leading: Icon(
                    mosqueIcons[idx],
                    color: Color(0xFFC69840),
                  ),
                  title: Text(
                    name,
                    style: TextStyle(
                      color: Color(0xFFC69840),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                    navigateToWorkPage(name); // Navigate to the correct page
                  },
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Close",
                  style: TextStyle(color: Color(0xFFC69840)),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void navigateToWorkPage(String name) {
    switch (name) {
      case "Excavation Work":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MosqueExavationWork()),
        );
        break;
      case "Foundation Work":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FoundationWork()),
        );
        break;
      case "First Floor":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FirstFloorWork()),
        );
        break;
      case "Tiles Work":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TilesWork()),
        );
        break;
      case "Sanitary Work":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SanitaryWork()),
        );
        break;
      case "Ceiling Work":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CeilingWork()),
        );
        break;
      case "Paint Work":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaintWork()),
        );
        break;
      case "Electricity Work":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ElectricityWork()),
        );
        break;
      case "Doors Work":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoorsWork()),
        );
        break;
    }
  }
}




