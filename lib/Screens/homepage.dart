import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ViewModels/AllNoorViewModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final HomeController controller = Get.put(HomeController());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
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
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                        title: Text(
                          'Clockin Timer',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                        ),
                        subtitle: Obx(() {
                          return Text(
                            controller.formattedDurationString.value,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white54),
                          );
                        }),
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
                          crossAxisSpacing: 26,
                          mainAxisSpacing: 26,
                          shrinkWrap: true,
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
              ],
            ),
          ),
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
    );
  }

  Widget buildCard(BuildContext context, String imagePath, String name, String route) {
    return GestureDetector(
      onTap: () {
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
                Image.asset(
                  imagePath,
                  height: 120,
                  width: 120,
                ),
                const SizedBox(height: 8),
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
