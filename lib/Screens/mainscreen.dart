import 'package:flutter/material.dart';
import 'drawer_screen.dart'; // Import your DrawerScreen
import 'home_page.dart'; // Import your HomeScreen

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(), // Replace with your actual DrawerScreen
          HomePage(), // Replace with your actual HomeScreen
        ],
      ),
    );
  }
}
