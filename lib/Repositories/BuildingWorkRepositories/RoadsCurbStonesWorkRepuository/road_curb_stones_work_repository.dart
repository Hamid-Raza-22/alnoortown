

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCurbstonesWorkModel/road_curb_stones_work_model.dart';
import 'package:flutter/foundation.dart';

class RoadCurbStonesWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<RoadCurbStonesWorkModel>> getRoadCurbStonesWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameRoadCurbStone,
        columns: ['id', 'blockNo', 'roadNo','totalLength','compStatus','date','time']
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
    List<RoadCurbStonesWorkModel> roadCurbStonesWork = [];
    for (int i = 0; i < maps.length; i++) {
      roadCurbStonesWork.add(RoadCurbStonesWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed RoadCurbStonesWorkModel objects:');
    }

    return roadCurbStonesWork;
  }

  Future<int>add(RoadCurbStonesWorkModel roadCurbStonesWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameRoadCurbStone,roadCurbStonesWorkModel.toMap());
  }

  Future<int>update(RoadCurbStonesWorkModel roadCurbStonesWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameRoadCurbStone,roadCurbStonesWorkModel.toMap(),
        where: 'id = ?', whereArgs: [roadCurbStonesWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameRoadCurbStone,
        where: 'id = ?', whereArgs: [id]);
  }
}