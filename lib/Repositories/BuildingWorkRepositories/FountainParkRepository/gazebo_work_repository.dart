

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/gazebo_work_model.dart';
import 'package:flutter/foundation.dart';

class GazeboWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<GazeboWorkModel>> getGazeboWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameGazeboWork,
        columns: ['id', 'startDate', 'expectedCompDate','gazeboWorkCompStatus','date','time']
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