import 'package:al_noor_town/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/building_work.dart';
import 'Screens/development_page.dart';
import 'Screens/homepage.dart';
import 'Screens/material_shifting.dart';
import 'Screens/new_material.dart';

void main() => runApp(
  GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => SplashScreen()),
      GetPage(name: '/home', page: () => HomePage()),
      GetPage(name: '/development', page: () => DevelopmentPage()),
      GetPage(name: '/materialShifting', page: () => MaterialShiftingPage()),
      GetPage(name: '/newMaterial', page: () => new_material()),
      GetPage(name: '/buildingWork', page: () => building_work()),
    ],
  ),
);

