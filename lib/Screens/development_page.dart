import 'package:flutter/material.dart';
import 'light_poles_work.dart';
import 'maindrain_work_page.dart';
import 'road_maintenance_page.dart';
import 'sewerage_work_page.dart';


class DevelopmentPage extends StatefulWidget {
  const DevelopmentPage({Key? key}) : super(key: key);

  @override
  State<DevelopmentPage> createState() => _DevelopmentPageState();
}

class _DevelopmentPageState extends State<DevelopmentPage> {
  double screenHeight = 0;
  double screenWidth = 0;
  bool startAnimation = false;

  List<String> texts = [
    "Road Maintenance",
    "Sewerage Work",
    "Light Poles Work",
    "MainDrain Work",
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 20),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 20,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: texts.length,
                    itemBuilder: (context, index) {
                      return item(index);
                    },
                  ),
                  const SizedBox(height: 50),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RoadMaintenancePage()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SewerageWork()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  LightPolesWork()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => maindrain()),
            );
            break;
        }
      },
      child: AnimatedContainer(
        height: 130,
        width: screenWidth,
        curve: Curves.linear,
        duration: Duration(milliseconds: 300 + (index * 200)),
        transform: Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 20,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0.3, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                imagePaths[index],
                height: 58,
                width: 57,
              ),
            ),
            Container(
              width: 0.7,
              height: 80,
              color:  Colors.grey.withOpacity(0.3),
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  texts[index],
                  style: const TextStyle(
                    fontSize: 19,
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
