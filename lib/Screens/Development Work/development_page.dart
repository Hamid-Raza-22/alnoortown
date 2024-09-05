import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../Building Work/Mosque/MosqueExcavationWork/mosque_excavation_work.dart';
import 'Light poles work/poles.dart';
import 'Light poles work/poles_foundation.dart';
import 'Main Drain Work/asphaltwork.dart';
import 'Main Drain Work/brick_work.dart';
import 'Main Drain Work/iron_work.dart';
import 'Main Drain Work/main_drain_excavation.dart';
import 'Main Drain Work/manholes _slabs.dart';
import 'Main Drain Work/plaster_work.dart';
import 'Main Drain Work/shuttering_work.dart';
import 'Road Maintenance/Machines/machines.dart';
import 'Road Maintenance/Water Tanker/water_tanker.dart';
import 'Sewerage Work/Backfiling/backfilling.dart';
import 'Sewerage Work/Excavation/excavation.dart';
import 'Sewerage Work/Manholes/manholes.dart';
import 'Sewerage Work/Pipelying/pipe_lying.dart';


class DevelopmentPage extends StatefulWidget {
    DevelopmentPage({super.key});

  @override
  State<DevelopmentPage> createState() => _DevelopmentPageState();
}

class _DevelopmentPageState extends State<DevelopmentPage> {
  double screenHeight = 0;
  double screenWidth = 0;
  bool startAnimation = false;

  List<String> texts = [
    'road_maintenance'.tr(),
    'sewerage_work'.tr(),
    'light_poles_work'.tr(),
    'maindrain_work'.tr(),
  ];

  List<String> imagePaths = [
    "assets/images/road_maintenance.png",
    "assets/images/maindrain_work.png",
    "assets/images/light_poles_work.png",
    "assets/images/sewerage_work.png",
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:   Icon(
            Icons.arrow_back,
            color: Color(0xFFC69840),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:   Text(
          'development_work'.tr(),
          style: TextStyle(
            fontFamily: 'Avenir Next',
            fontSize: 20,
            color: Color(0xFFC69840),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
              SizedBox(height: 60),
            SingleChildScrollView(
              physics:   BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 20,
              ),
              child: Column(
                children: [
                    SizedBox(height: 10),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: texts.length,
                    itemBuilder: (context, index) {
                      return item(index);
                    },
                  ),
                    SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(int index) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title:   Text(
                    'pick_your_machinery'.tr(),
                    style: TextStyle(
                      color: Color(0xFFC69840),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                  Machines()),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/machines.png',
                              height: 100,
                              width: 100,
                            ),
                              SizedBox(height: 10),
                              Text(
                              'machine'.tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840),
                              ),
                            ),
                          ],
                        ),
                      ),
                        SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>   WaterTanker()),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/water_tanker.png',
                              height: 100,
                              width: 100,
                            ),
                              SizedBox(height: 10),
                              Text(
                              'water_tanker'.tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child:   Text(
                        'close'.tr(),
                        style: TextStyle(color: Color(0xFFC69840)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.white,
                  contentPadding:   EdgeInsets.all(20),
                );
              },
            );
            break;
          case 1:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title:   Text(
                    'select_your_work'.tr(),
                    style: TextStyle(
                      color: Color(0xFFC69840),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>   Excavation()),
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/Excavation.png',
                                  height: 100,
                                  width: 100,
                                ),
                                  SizedBox(height: 10),
                                  Text(
                                  'excavation'.tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFC69840),
                                  ),
                                ),
                              ],
                            ),
                          ),
                            SizedBox(width: 40),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>   Backfiling()),
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/backfiling.png',
                                  height: 100,
                                  width: 100,
                                ),
                                  SizedBox(height: 10),
                                  Text(
                                  'back_filing'.tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFC69840),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                        SizedBox(height: 20), // Adjust height as needed
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>   Manholes()),
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/manholes.png',
                                  height: 100,
                                  width: 100,
                                ),
                                  SizedBox(height: 10),
                                  Text(
                                  'manholes'.tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFC69840),
                                  ),
                                ),
                              ],
                            ),
                          ),
                            SizedBox(width: 40),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>   Pipelying()),
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/pipelines.png',
                                  height: 100,
                                  width: 100,
                                ),
                                  SizedBox(height: 10),
                                  Text(
                                  'pipe_laying'.tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFC69840),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child:   Text(
                        'close'.tr(),
                        style: TextStyle(color: Color(0xFFC69840)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.white,
                  contentPadding:   EdgeInsets.all(20),
                );
              },
            );
            break;
          case 2:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title:   Text(
                    'select_your_work'.tr(),
                    style: TextStyle(
                      color: Color(0xFFC69840),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                  PolesFoundation()),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/pol-01.png',
                              height: 100,
                              width: 100,
                            ),
                              SizedBox(height: 10),
                              Text(
                              'poles_excavation'.tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840),
                              ),
                            ),
                          ],
                        ),
                      ),
                        SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>   Poles()),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/polesssssss-01.png',
                              height: 100,
                              width: 100,
                            ),
                              SizedBox(height: 5),
                              Text(
                              'poles'.tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840),
                              ),
                            ),
                          ],
                        ),
                      ),
                        SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>   MosqueExcavationWork()),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/lightwire-01.png',
                              height: 100,
                              width: 100,
                            ),
                              SizedBox(height: 5),
                              Text(
                              'light_wires'.tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child:   Text(
                        'close'.tr(),
                        style: TextStyle(color: Color(0xFFC69840)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.white,
                  contentPadding:   EdgeInsets.all(20),
                );
              },
            );
            break;
          case 3:
            showDialog(
              context: context,
              builder: (BuildContext context) {

                return AlertDialog(
                  title:   Text(
                    'select_your_work'.tr(),
                    style: TextStyle(
                      color: Color(0xFFC69840),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   BrickWork()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/pol-01.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    SizedBox(height: 5),
                                    Text(
                                    'brick_work'.tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   PlasterWork()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/polesssssss-01.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    SizedBox(height: 5),
                                    Text(
                                    'plaster_work'.tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   ShutteringWork()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/lightwire-01.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    SizedBox(height: 5),
                                    Text(
                                    'shuttering_work'.tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                          SizedBox(width: 10), // Reduced space between columns
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   IronWork()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/ironworkk-01.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    SizedBox(height: 5),
                                    Text(
                                    'iron_work'.tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   ManholesSlabs()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/Excavation.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    SizedBox(height: 5),
                                    Text(
                                    'manholes_slabs'.tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   AsphaltWork()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/Excavation.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    SizedBox(height: 5),
                                    Text(
                                    'asphalt_work'.tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   MainDrainExcavation()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/Excavation.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    SizedBox(height: 5),
                                    Text(
                                    'main_drain_excavation'.tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child:   Text(
                        'close'.tr(),
                        style: TextStyle(color: Color(0xFFC69840)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.white,

                  contentPadding:   EdgeInsets.all(20),
                );
              },
            );
            break;
        }
      },
      child: AnimatedContainer(
        height: 90, // Reduced height to make the cards slimmer
        width: screenWidth,
        curve: Curves.linear,
        duration: Duration(milliseconds: 300 + (index * 200)),
        transform: Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
        margin:   EdgeInsets.only(
          bottom: 10, // Reduced bottom margin for less space between cards
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 25, // Reduced horizontal padding
        ),
        decoration: BoxDecoration(
          color:   Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Padding(
              padding:   EdgeInsets.all(6.0),
              child: Image.asset(
                imagePaths[index],
                height: 45,
                width: 45,
              ),
            ),
            Container(
              width: 0.5,
              height: 40,
              color: Colors.grey.withOpacity(0.3),
              margin:   EdgeInsets.symmetric(horizontal: 6),
            ),
            Expanded(
              child: Padding(
                padding:   EdgeInsets.only(left: 6.0),
                child: Text(
                  texts[index],
                  style:   TextStyle(
                    fontSize: 16,
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
}
