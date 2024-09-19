import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class Config {
  static late FirebaseRemoteConfig remoteConfig;

  static Future<void> initialize() async {
    remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 1),
      // Set to 1 minute for development; change to a larger interval for production
      minimumFetchInterval: Duration(seconds: 1),
    ));
    await fetchLatestConfig(); // Fetch and activate immediately
  }

  static Future<void> fetchLatestConfig() async {
    try {
      bool updated = await remoteConfig.fetchAndActivate();
      if (updated) {
        if (kDebugMode) {
          print('Remote config updated');
        }
      } else {
        if (kDebugMode) {
          print('No changes in remote config');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch remote config: $e');
      }
    }
  }

  // Access the config parameters
  static String get apiUrl => remoteConfig.getString('Water_Tanker_url');
  static String get waterTankerPostApi => remoteConfig.getString('WaterTankerApi');
  static String get machinePostApi => remoteConfig.getString('Machine_url');
}
