

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/main_stage_work_model.dart';
import 'package:flutter/foundation.dart';

class MainStageWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MainStageWorkModel>> getMainStageWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameStage,
        columns: ['id', 'startDate', 'expectedCompDate','mainStageWorkCompStatus','date','time']
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
    List<MainStageWorkModel> mainStageWork = [];
    for (int i = 0; i < maps.length; i++) {
      mainStageWork.add(MainStageWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MainStageWorkModel objects:');
    }

    return mainStageWork;
  }

  Future<int>add(MainStageWorkModel mainStageWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameStage,mainStageWorkModel.toMap());
  }

  Future<int>update(MainStageWorkModel mainStageWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameStage,mainStageWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mainStageWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameStage,
        where: 'id = ?', whereArgs: [id]);
  }
}