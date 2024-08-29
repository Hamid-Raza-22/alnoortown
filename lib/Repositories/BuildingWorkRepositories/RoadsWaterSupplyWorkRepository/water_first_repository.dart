

import 'package:al_noor_town/Database/dbHelper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsWaterSupplyWorkModel/water_first_model.dart';
import 'package:flutter/foundation.dart';

class WaterFirstRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<WaterFirstModel>> getWaterFirst() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameWaterFirst,
        columns: ['id', 'blockNo', 'roadNo','roadSide','totalLength','startDate','expectedCompDate','waterSupplyCompStatus']
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
    List<WaterFirstModel> waterFirst = [];
    for (int i = 0; i < maps.length; i++) {
      waterFirst.add(WaterFirstModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed WaterFirstModel objects:');
    }

    return waterFirst;
  }

  Future<int>add(WaterFirstModel waterFirstModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameWaterFirst,waterFirstModel.toMap());
  }

  Future<int>update(WaterFirstModel waterFirstModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameWaterFirst,waterFirstModel.toMap(),
        where: 'id = ?', whereArgs: [waterFirstModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameWaterFirst,
        where: 'id = ?', whereArgs: [id]);
  }
}