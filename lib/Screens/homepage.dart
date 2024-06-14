import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ViewModels/AllNoorViewModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  subtitle: Text(
                    '00:00:00',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white54),
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
                  const SizedBox(height: 120),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 29,
                    mainAxisSpacing: 29,
                    shrinkWrap: true,
                    children: <Widget>[
                      buildCard(context, 'assets/images/development_work.png', '/development'),
                      buildCard(context, 'assets/images/material_shifting.png', '/materialShifting'),
                      buildCard(context, 'assets/images/new_material.png', '/newMaterial'),
                      buildCard(context, 'assets/images/building_work.png', '/buildingWork'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context, String imagePath, String route) {
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
            child: Center(
              child: Image.asset(
                imagePath,
                height: 120,
                width: 120,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
