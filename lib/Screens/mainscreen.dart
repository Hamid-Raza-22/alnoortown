import 'package:flutter/material.dart';
import 'Menu.dart'; // Import your DrawerScreen
import 'home_page.dart'; // Import your HomeScreen

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Menu(), // Replace with your actual DrawerScreen
          HomePage(), // Replace with your actual HomeScreen
        ],
      ),
    );
  }
}
