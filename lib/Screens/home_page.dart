import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ViewModels/all_noor_view_model.dart';
import 'drawer_screen.dart'; // Import your drawer screen

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final HomeController controller = Get.put(HomeController());

  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;

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
      xOffset = isDrawerOpen ? 0 : 290;
      yOffset = isDrawerOpen ? 0 : 80;
      isDrawerOpen = !isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          DrawerScreen(),
          AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(isDrawerOpen ? 0.85 : 1.00)
              ..rotateZ(isDrawerOpen ? -50 : 0),
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFC69840),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              /*Text(
                                'Clock In Timer :',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontSize: 14, // Adjusted font size
                                ),
                              ),*/
                              const SizedBox(width: 10), // Space between text and timer
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
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
                  Container(
                    color: const Color(0xFFC69840),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(200)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              buildCard(context, 'assets/images/development_work.png', 'Development Work', '/development'),
                              buildCard(context, 'assets/images/material_shifting.png', 'Material Shifting', '/materialShifting'),
                              buildCard(context, 'assets/images/new_material.png', 'New Material', '/newMaterial'),
                              buildCard(context, 'assets/images/building_work.png', 'Building Work', '/buildingWork'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 160),
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Obx(() {
                      return ElevatedButton.icon(
                        onPressed: () async {
                          controller.toggleClockInOut();
                        },
                        icon: Icon(
                          controller.isClockedIn.value ? Icons.timer_off : Icons.timer,
                          color: const Color(0xFFC69840),
                        ),
                        label: Text(
                          controller.isClockedIn.value ? 'Clock Out' : 'Clock In',
                          style: const TextStyle(fontSize: 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFFC69840),
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
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(
                isDrawerOpen ? Icons.arrow_back_ios : Icons.menu,
                color: Colors.white,
              ),
              onPressed: _toggleDrawer,
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
              offset: const Offset(0, 3),
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
                const SizedBox(height: 8),
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFC69840),
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
