

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsWaterSupplyWorkModel/back_filling_ws_model.dart';
import 'package:flutter/foundation.dart';

class BackFillingWsRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<BackFillingWsModel>> getBackFillingWs() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameWaterSupplyBackFilling,
        columns: ['id', 'blockNo', 'roadNo','roadSide','totalLength','startDate','expectedCompDate','waterSupplyBackFillingCompStatus','date','time','posted']
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
    List<BackFillingWsModel> backFillingWs = [];
    for (int i = 0; i < maps.length; i++) {
      backFillingWs.add(BackFillingWsModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed BackFillingWsModel objects:');
    }

    return backFillingWs;
  }
  Future<List<BackFillingWsModel>> getUnPostedWaterSupplyBackFilling() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameWaterSupplyBackFilling,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<BackFillingWsModel> backFillingWs = maps.map((map) => BackFillingWsModel.fromMap(map)).toList();
    return backFillingWs;
  }
  Future<int>add(BackFillingWsModel backFillingWsModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameWaterSupplyBackFilling,backFillingWsModel.toMap());
  }

  Future<int>update(BackFillingWsModel backFillingWsModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameWaterSupplyBackFilling,backFillingWsModel.toMap(),
        where: 'id = ?', whereArgs: [backFillingWsModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameWaterSupplyBackFilling,
        where: 'id = ?', whereArgs: [id]);
  }
}