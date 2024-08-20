import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class HomeController extends GetxController {
  var isTapped = false.obs;
  DateTime? startTime;
  Timer? _timer;
  var isClockedIn = false.obs;
  var formattedDurationString = '00:00:00'.obs;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initializeNotification();
    _loadClockStatus();
    _clockRefresh();
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
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

  void toggleClockInOut() {
    if (isClockedIn.value) {
      _stopTimer();
      Workmanager().cancelAll();
      startTime = null;
      _saveClockStatus(false);
      newsecondpassed = 0;
      formattedDurationString.value = '00:00:00';
    } else {
      _saveCurrentTime();
      _saveClockStatus(true);
      startTimer();
      Workmanager().registerPeriodicTask(
        "1",
        "simplePeriodicTask",
        frequency: const Duration(minutes: 15),
      );
    }
    isClockedIn.value = !isClockedIn.value;
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
