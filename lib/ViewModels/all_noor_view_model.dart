import 'dart:async';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/AttendenceModels/attendance_in_model.dart';
import 'package:al_noor_town/ViewModels/AttendanceViewModel/attendance_in_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import '../Models/AttendenceModels/attendance_out_model.dart';
import '../main.dart';
import 'AttendanceViewModel/attendance_out_view_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart' show Permission, PermissionActions, PermissionStatus, PermissionStatusGetters, openAppSettings;

class HomeController extends GetxController {
  var isTapped = false.obs;
  DateTime? startTime;
  Timer? _timer;
  var isClockedIn = false.obs;
  var formattedDurationString = '00:00:00'.obs;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final attendanceInViewModel = Get.put(AttendanceInViewModel());
final attendanceOutViewModel = Get.put(AttendanceOutViewModel());
  @override
  void onInit() {
    super.onInit();
    _initializeNotification();
    _loadClockStatus();
    _clockRefresh();
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  }
  Future<bool> _isLocationEnabled() async {
    // Add your logic to check if location services are enabled
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    return isLocationEnabled;
  }
  void _saveCurrentTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime currentTime = DateTime.now();
    String formattedTime = _formatDateTime(currentTime);
    prefs.setString('savedTime', formattedTime);
    if (kDebugMode) {
      print("Save Current Time");
    }
  }
  Future<void> saveCurrentLocation() async {
   // if (!mounted) return; // Check if the widget is still mounted


    PermissionStatus permission = await Permission.location.request();

    if (permission.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        globalLatitude = position.latitude;
        globalLongitude = position.longitude;

        if (kDebugMode) {
          print('Latitude: $globalLatitude, Longitude: $globalLongitude');
        }

        // Default address to "Pakistan" initially
        String address1 = "Pakistan";

        try {
          // Attempt to get the address from coordinates
          List<Placemark> placemarks = await placemarkFromCoordinates(
              globalLatitude!, globalLongitude!);
          Placemark? currentPlace = placemarks.isNotEmpty ? placemarks[0] : null;

          if (currentPlace != null) {
            address1 = "${currentPlace.thoroughfare ?? ''} ${currentPlace.subLocality ?? ''}, ${currentPlace.locality ?? ''} ${currentPlace.postalCode ?? ''}, ${currentPlace.country ?? ''}";

            // Check if the constructed address is empty, fallback to "Pakistan"
            if (address1.trim().isEmpty) {
              address1 = "Pakistan";
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error getting placemark: $e');
          }
          // Keep the address as "Pakistan"
        }

        liveAddress = address1;
        // GPS is enabled

        if (kDebugMode) {
          print('Address is: $address1');
        }

      } catch (e) {
        if (kDebugMode) {
          print('Error getting location: $e');
        }
        //  isGpsEnabled = false; // GPS is not enabled
      }
    }


  }
  String _formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('HH:mm:ss');
    return formatter.format(dateTime);
  }

  int newsecondpassed = 0;
  void _clockRefresh() async {
    newsecondpassed = 0;
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.reload();
      newsecondpassed = prefs.getInt('secondsPassed') ?? 0;
      formattedDurationString.value = _formatDuration(newsecondpassed.toString());
    });
  }

  Future<String> _stopTimer() async {
    _timer?.cancel();
    String totalTime = _formatDuration(newsecondpassed.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('secondsPassed', 0);
    newsecondpassed = 0;
    return totalTime;
  }

  String _formatDuration(String secondsString) {
    int seconds = int.parse(secondsString);
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String secondsFormatted = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$secondsFormatted';
  }

  void startTimerFromSavedTime() {
    SharedPreferences.getInstance().then((prefs) async {
      String savedTime = prefs.getString('savedTime') ?? '00:00:00';
      List<String> timeComponents = savedTime.split(':');
      int hours = int.parse(timeComponents[0]);
      int minutes = int.parse(timeComponents[1]);
      int seconds = int.parse(timeComponents[2]);
      int totalSavedSeconds = hours * 3600 + minutes * 60 + seconds;
      final now = DateTime.now();
      int totalCurrentSeconds = now.hour * 3600 + now.minute * 60 + now.second;
      newsecondpassed = totalCurrentSeconds - totalSavedSeconds;
      if (newsecondpassed < 0) {
        newsecondpassed = 0;
      }
      await prefs.setInt('secondsPassed', newsecondpassed);
      if (kDebugMode) {
        print("Loaded Saved Time");
      }
    });
  }

  _loadClockStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isClockedIn.value = prefs.getBool('isClockedIn') ?? false;
    if (isClockedIn.value) {
      startTimerFromSavedTime();
      startTimer(); // Start the timer if the user is clocked in
    } else {
      prefs.setInt('secondsPassed', 0);
    }
  }

  _saveClockStatus(bool clockedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isClockedIn', clockedIn);
    isClockedIn.value = clockedIn;
  }

  void _initializeNotification() {
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettings = const InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> startTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      newsecondpassed++;
      await prefs.setInt('secondsPassed', newsecondpassed);
      formattedDurationString.value = _formatDuration(newsecondpassed.toString());
    });
  }
  String _getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('d MMM yyyy');
    return formatter.format(now);
  }
  String _getFormattedtime() {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm:ss a');
    return formatter.format(now);
  }
  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      // Handle the case when permission is denied
      Get.snackbar(
        "Permission Required",
        "Location permissions are required to clock in.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }
  Future<void> toggleClockInOut() async {
    if (isClockedIn.value) {
      _stopTimer();
      Workmanager().cancelAll();
      startTime = null;
      _saveClockStatus(false);
      newsecondpassed = 0;
      formattedDurationString.value = '00:00:00';

      await attendanceOutViewModel.addAttendOut(AttendanceOutModel(
          time_out: _getFormattedtime(),
          latitude: globalLatitude,
          longitude: globalLongitude,
          address_out: liveAddress,
          user_id: userId,
          date: _getFormattedDate()
      ));

      await attendanceOutViewModel.fetchAllAttendOut();
      await attendanceOutViewModel.postDataFromDatabaseToAPI();

      print("isClockedIn after forcing false: ${isClockedIn.value}");
      print("Clocked Out");
      isClockedIn.value = false; // Force it to be false after clock out
    } else {

      bool isLocationEnabled = await _isLocationEnabled();

      if (!isLocationEnabled) {
        Get.snackbar(
          "Location Services Required",
          "Please enable GPS or location services before clocking in.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
      bool isLocationPermissionGranted = await _checkLocationPermission();
      if (!isLocationPermissionGranted) {
        await _requestLocationPermission();
      }
      await saveCurrentLocation();
     // await _getCurrentLocation();
      await attendanceInViewModel.addAttend(AttendanceInModel(
          time_in: _getFormattedtime(),
          latitude: globalLatitude,
          longitude: globalLongitude,
          live_address: liveAddress,
          user_id: userId,
          date: _getFormattedDate()
      ));

      await attendanceInViewModel.fetchAllAttend();
      await attendanceInViewModel.postDataFromDatabaseToAPI();

      _saveCurrentTime();
      _saveClockStatus(true);
      startTimer();

      Workmanager().registerPeriodicTask(
        "1",
        "simplePeriodicTask",
        frequency: const Duration(minutes: 15),
      );


      print("Clocked In");
    }

    // isClockedIn.value = !isClockedIn.value;
    print("isClockedIn: ${isClockedIn.value}");
  }
  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
  void toggleTapped() {
    isTapped.value = !isTapped.value;
  }

  void showRunningTimerNotification(String timerValue) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      autoCancel: false,
    );
    const platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Clockin Timer',
      timerValue,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

}
