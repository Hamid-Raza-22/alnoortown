

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsEdgingWorkModel/roads_edging_work_model.dart';
import 'package:flutter/foundation.dart';

class RoadsEdgingWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<RoadsEdgingWorkModel>> getRoadsEdgingWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameRoadsEdging,
        columns: ['id', 'blockNo', 'roadNo','roadSide','totalLength','startDate','expectedCompDate','roadsEdgingCompStatus','date','time']
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
    List<RoadsEdgingWorkModel> roadsEdgingWork = [];
    for (int i = 0; i < maps.length; i++) {
      roadsEdgingWork.add(RoadsEdgingWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed RoadsEdgingWorkModel objects:');
    }

    return roadsEdgingWork;
  }

  Future<int>add(RoadsEdgingWorkModel roadsEdgingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameRoadsEdging,roadsEdgingWorkModel.toMap());
  }

  Future<int>update(RoadsEdgingWorkModel roadsEdgingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameRoadsEdging,roadsEdgingWorkModel.toMap(),
        where: 'id = ?', whereArgs: [roadsEdgingWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameRoadsEdging,
        where: 'id = ?', whereArgs: [id]);
  }
}