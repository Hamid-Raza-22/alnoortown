

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/gazebo_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class GazeboWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<GazeboWorkModel>> getGazeboWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameGazeboWork,
        columns: ['id', 'start_date', 'expected_comp_date','gazebo_work_comp_status','gazebo_work_date','time','posted','user_id']
    );

    // Print the raw data retrieved from the database
    if (kDebugMode) {
      print('Raw data from database:');
    }
    for (var map in maps) {
      if (kDebugMode) {
        print(map);
      }
    }

    // Convert the raw data into a list of
    List<GazeboWorkModel> gazeboWork = [];
    for (int i = 0; i < maps.length; i++) {
      gazeboWork.add(GazeboWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed GazeboWorkModel objects:');
    }

    return gazeboWork;
  }
  Future<void> fetchAndSaveGazeboWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlGazeboWork);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      GazeboWorkModel model = GazeboWorkModel.fromMap(item);
      await dbClient.insert(tableNameGazeboWork, model.toMap());
    }
  }
  Future<List<GazeboWorkModel>> getUnPostedGazebo() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameGazeboWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<GazeboWorkModel> gazeboWork = maps.map((map) => GazeboWorkModel.fromMap(map)).toList();
    return gazeboWork;
  }
  Future<int>add(GazeboWorkModel gazeboWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameGazeboWork,gazeboWorkModel.toMap());
  }

  Future<int>update(GazeboWorkModel gazeboWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameGazeboWork,gazeboWorkModel.toMap(),
        where: 'id = ?', whereArgs: [gazeboWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameGazeboWork,
        where: 'id = ?', whereArgs: [id]);
  }
}