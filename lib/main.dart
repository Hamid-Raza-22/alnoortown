import 'dart:async';
import 'dart:io';
import 'package:al_noor_town/Screens/BuildingWork/building_work_navigation.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/development_page.dart';
import 'package:al_noor_town/Screens/MaterialShifting/material_shifting.dart';
import 'package:al_noor_town/Screens/NewMaterial/new_material.dart';
import 'package:al_noor_town/Screens/PolicyDBox.dart';
import 'package:al_noor_town/Screens/home_page.dart';
import 'package:al_noor_town/Screens/splash_screen.dart';
 import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:al_noor_town/ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'Screens/login_page.dart';
import 'Services/StripeServices/consts.dart';
import 'ViewModels/LoginViewModel/login_view_model.dart';
import 'ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import 'ViewModels/all_noor_view_model.dart';
import 'Services/FirebaseServices/firebase_options.dart';
LoginViewModel loginViewModel =Get.put(LoginViewModel());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Config.initialize();
 // await loginViewModel.fetchAndSaveLoginData();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
//  await dotenv.load();
//   Stripe.publishableKey = stripePublishableKey;
  // Initialize ViewModels for the app
  // Get.lazyPut(() => BlockDetailsViewModel());  // Ensure HomeViewModel is lazily initialized
  // Get.lazyPut(() => RoadDetailsViewModel());  // Ensure HomeViewModel is lazily initialized
  // Check internet connectivity before running the app

  runApp(
    Phoenix(
    child:EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ur'),
        Locale('fr'),
        Locale('ru'),
        Locale('de'),
        Locale('zh'),
        Locale('ar'),
      ],
      path: 'assets/langs', // Path to your language files
      fallbackLocale: const Locale('en'), // Default language
      child: MyApp(isAuthenticated), // Separate widget to keep the code clean
    ),
  )
  );
}
// Function to check internet connection
Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    return false; // No internet connection
  } else {
    try {
      // Test a network request to verify if internet access is available
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Internet connection is working
      }
    } catch (e) {
      return false; // No internet connection
    }
  }
  return false;
}

void startTimerAndUpdateNotification() async {
  final prefs = await SharedPreferences.getInstance();

  // Get startTime from SharedPreferences
  final startTimeString = prefs.getString('startTime');

  // Check if startTime is null and return early if it is
  if (startTimeString == null) {
    print('Error: startTime is null, cannot start the timer');
    return;
  }

  final startTime = DateTime.parse(startTimeString);

  Timer.periodic(Duration(seconds: 1), (Timer timer) async {
    final isClockedIn = prefs.getBool('isClockedIn') ?? false;
    if (!isClockedIn) {
      timer.cancel(); // Stop the timer if the user is clocked out
      return;
    }

    // Calculate the duration and format it as HH:mm:ss
    final duration = DateTime.now().difference(startTime);
    final formattedDuration = duration.toString().split('.').first.padLeft(8, "0");

    // Update the notification with the live timer value
    await HomeController().showRunningTimerNotification(formattedDuration);
  });
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    final isClockedIn = prefs.getBool('isClockedIn') ?? false;

    if (isClockedIn) {
      // Start the live timer when the user is clocked in
      startTimerAndUpdateNotification();
    }
    return Future.value(true);
  });
}
class MyApp extends StatelessWidget {
  final bool isAuthenticated;

  MyApp(this.isAuthenticated);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      initialRoute: isAuthenticated ? '/home' : '/policy',
      //initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/policy', page: () => PolicyDialog()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () =>  HomePage()),
        GetPage(name: '/development', page: () =>  DevelopmentPage()),
        GetPage(name: '/materialShifting', page: () =>  const MaterialShiftingPage()),
        GetPage(name: '/newMaterial', page: () => NewMaterial()),
        GetPage(name: '/buildingWork', page: () => Building_Navigation_Page()),
      ],
    );
  }
}
