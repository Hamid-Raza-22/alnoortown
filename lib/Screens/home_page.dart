import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import '../ViewModels/all_noor_view_model.dart';
import 'Menu.dart'; // Import your drawer screen
import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final HomeController controller = Get.put(HomeController());

  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;

  bool get isRtl => Localizations.localeOf(context).languageCode == 'ur';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _toggleDrawer() {
    setState(() {
      if (isDrawerOpen) {
        xOffset = 0;
        yOffset = 0;
      } else {
        xOffset = isRtl ? -290 : 290;
        yOffset = 80;
      }
      isDrawerOpen = !isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Menu(),
          AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(isDrawerOpen ? 0.85 : 1.00)
              ..rotateZ(isDrawerOpen ? (isRtl ? 50 : -50) : 0),
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFC69840),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(width: 10), // Space between text and timer
                              Obx(() {
                                return Text(
                                  controller.formattedDurationString.value,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white54,
                                    fontSize: 18, // Adjusted font size
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFFC69840),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(200)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              buildCard(context, 'assets/images/development_work.png', 'development_work'.tr(), '/development'),
                              buildCard(context, 'assets/images/material_shifting.png', 'material_shifting'.tr(), '/materialShifting'),
                              buildCard(context, 'assets/images/new_material.png', 'new_material'.tr(), '/newMaterial'),
                              buildCard(context, 'assets/images/building_work.png', 'building_work'.tr(), '/buildingWork'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 160),
                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Obx(() {
                      return ElevatedButton.icon(
                        onPressed: () async {
                          controller.toggleClockInOut();
                        },
                        icon: Icon(
                          controller.isClockedIn.value ? Icons.timer_off : Icons.timer,
                          color: Color(0xFFC69840),
                        ),
                        label: Text(
                          controller.isClockedIn.value ? 'clock_out'.tr() : 'clock_in'.tr(),
                          style: TextStyle(fontSize: 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFFC69840),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: isRtl ? ui.TextDirection.rtl : ui.TextDirection.ltr,
            child: Positioned(
              top: 50,
              right: isRtl ? 20 : null,
              left: !isRtl ? 20 : null,
              child: IconButton(
                icon: Icon(
                  isDrawerOpen ? Icons.arrow_back_ios : Icons.menu,
                  color: Colors.white,
                ),
                onPressed: _toggleDrawer,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildCard(BuildContext context, String imagePath, String name, String route) {
    return GestureDetector(
        onTap: () {
          // Directly navigate to the route without checking if the user is clocked in
          Get.toNamed(route);
        },
        child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        imagePath,
                        height: 120,
                        width: 120,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Color(0xFFC69840),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
       );
  }
}