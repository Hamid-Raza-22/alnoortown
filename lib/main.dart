import 'package:al_noor_town/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'Screens/Building Work/building_work_navigation.dart';
import 'ViewModels/AllNoorViewModel.dart';
import 'Screens/Building Work/Mosque/mosque_exavation_work.dart';
import 'Screens/Development Work/development_page.dart';
import 'Screens/homepage.dart';
import 'Screens/Material Shifting/material_shifting.dart';
import 'Screens/New Material/new_material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/development', page: () => const DevelopmentPage()),
        GetPage(name: '/materialShifting', page: () => const MaterialShiftingPage()),
      GetPage(name: '/newMaterial', page: () => const NewMaterial()),
      GetPage(name: '/buildingWork', page: () => const  Building_Navigation_Page()),
    ],

  ),
);
}
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    final isClockedIn = prefs.getBool('isClockedIn') ?? false;
    if (isClockedIn) {
      final startTime = DateTime.parse(prefs.getString('startTime')!);
      final duration = DateTime.now().difference(startTime);
      final formattedDuration = duration.toString().split('.').first.padLeft(8, "0");

      // Update the notification with the current timer value
      HomeController().showRunningTimerNotification(formattedDuration);
    }
    return Future.value(true);
  });
}
