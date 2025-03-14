import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
    SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(  Duration(milliseconds: 3000), () {});
    Get.offNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/splashscreen.png'),
      ),
    );
  }
}

