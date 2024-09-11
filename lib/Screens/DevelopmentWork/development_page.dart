import 'package:al_noor_town/Screens/DevelopmentWork/LightPolesWork/PolesExcavation/poles_foundation.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/MainDrainWork/AsphaltWork/asphaltwork.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/MainDrainWork/BrickWork/brick_work.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/MainDrainWork/DrainExcavation/drain_excavation.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/MainDrainWork/IronWork/iron_work.dart';

import 'package:al_noor_town/Screens/DevelopmentWork/MainDrainWork/ManholesSlabs/manholes_slabs.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/MainDrainWork/PlasterWork/plaster_work.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/MainDrainWork/ShutteringWork/shuttering_work.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/RoadMaintenance/WaterTanker/water_tanker.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/SewerageWork/Backfiling/backfilling.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/SewerageWork/Excavation/excavation.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/SewerageWork/Manholes/manholes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LightPolesWork/LightWiresWork/light_wires_work.dart';
import 'LightPolesWork/Poles/poles.dart';
import 'RoadMaintenance/Machines/machines.dart';
import 'SewerageWork/Pipelying/pipe_lying.dart';




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
          icon:   const Icon(
            Icons.arrow_back,
            color: Color(0xFFC69840),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:   Text(
          'development_work'.tr(),
          style: const TextStyle(
            fontFamily: 'Avenir Next',
            fontSize: 20,
            color: const Color(0xFFC69840),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
              const SizedBox(height: 60),
            SingleChildScrollView(
              physics:   const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 20,
              ),
              child: Column(
                children: [
                    const SizedBox(height: 10),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: texts.length,
                    itemBuilder: (context, index) {
                      return item(index);
                    },
                  ),
                    const SizedBox(height: 10),
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
                    style: const TextStyle(
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
                              const SizedBox(height: 10),
                              Text(
                              'machine'.tr(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840),
                              ),
                            ),
                          ],
                        ),
                      ),
                        const SizedBox(height: 20),
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
                              const SizedBox(height: 10),
                              Text(
                              'water_tanker'.tr(),
                              style: const TextStyle(
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
                        style: const TextStyle(color: Color(0xFFC69840)),
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
                  contentPadding:   const EdgeInsets.all(20),
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
                    style: const TextStyle(
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
                                  const SizedBox(height: 10),
                                  Text(
                                  'excavation'.tr(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFC69840),
                                  ),
                                ),
                              ],
                            ),
                          ),
                            const SizedBox(width: 40),
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
                                  const SizedBox(height: 10),
                                  Text(
                                  'back_filing'.tr(),
                                  style: const TextStyle(
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
                        const SizedBox(height: 20), // Adjust height as needed
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
                                  const SizedBox(height: 10),
                                  Text(
                                  'manholes'.tr(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFC69840),
                                  ),
                                ),
                              ],
                            ),
                          ),
                            const SizedBox(width: 40),
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
                                  const SizedBox(height: 10),
                                  Text(
                                  'pipe_laying'.tr(),
                                  style: const TextStyle(
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
                        style: const TextStyle(color: Color(0xFFC69840)),
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
                  contentPadding:   const EdgeInsets.all(20),
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
                    style: const TextStyle(
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
                              const SizedBox(height: 10),
                              Text(
                              'poles_excavation'.tr(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840),
                              ),
                            ),
                          ],
                        ),
                      ),
                        const SizedBox(height: 20),
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
                              const SizedBox(height: 5),
                              Text(
                              'poles'.tr(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840),
                              ),
                            ),
                          ],
                        ),
                      ),
                        const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>   LightWiresWork()),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/lightwire-01.png',
                              height: 100,
                              width: 100,
                            ),
                              const SizedBox(height: 5),
                              Text(
                              'light_wires'.tr(),
                              style: const TextStyle(
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
                        style: const TextStyle(color: Color(0xFFC69840)),
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
                  contentPadding:   const EdgeInsets.all(20),
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
                    style: const TextStyle(
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
                                  MaterialPageRoute(builder: (context) =>   const BrickWork()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/curbstone.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    const SizedBox(height: 5),
                                    Text(
                                    'brick_work'.tr(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              const SizedBox(height: 15),
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
                                    'assets/images/plasterrr-01.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    const SizedBox(height: 5),
                                    Text(
                                    'plaster_work'.tr(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   const ShutteringWork()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/shuttringwork-01.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    const SizedBox(height: 5),
                                    Text(
                                    'shuttering_work'.tr(),
                                    style: const TextStyle(
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
                          const SizedBox(width: 10), // Reduced space between columns
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
                                    const SizedBox(height: 5),
                                    Text(
                                    'iron_work'.tr(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              const SizedBox(height: 15),
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
                                    'assets/images/slabsss-01.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    const SizedBox(height: 5),
                                    Text(
                                    'manholes_slabs'.tr(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   const AsphaltWork()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/rock-01.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    const SizedBox(height: 5),
                                    Text(
                                    'asphalt_work'.tr(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC69840),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   const DrainExcavation()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/maindrain-01.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                    const SizedBox(height: 5),
                                    Text(
                                    'drain_excavation'.tr(),
                                    style: const TextStyle(
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
                        style: const TextStyle(color: Color(0xFFC69840)),
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

                  contentPadding:   const EdgeInsets.all(20),
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
        margin:   const EdgeInsets.only(
          bottom: 10, // Reduced bottom margin for less space between cards
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 25, // Reduced horizontal padding
        ),
        decoration: BoxDecoration(
          color:   const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Padding(
              padding:   const EdgeInsets.all(6.0),
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
              margin:   const EdgeInsets.symmetric(horizontal: 6),
            ),
            Expanded(
              child: Padding(
                padding:   const EdgeInsets.only(left: 6.0),
                child: Text(
                  texts[index],
                  style:   const TextStyle(
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
