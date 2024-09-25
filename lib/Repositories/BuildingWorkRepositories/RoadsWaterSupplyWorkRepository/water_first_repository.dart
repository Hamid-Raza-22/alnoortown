

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsWaterSupplyWorkModel/water_first_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class WaterFirstRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<WaterFirstModel>> getWaterFirst() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameRoadsWaterSupplyWork,
        columns: ['id', 'block_no', 'roadNo','roadSide','totalLength','startDate','expectedCompDate','waterSupplyCompStatus','roads_water_supply_date','time','posted']
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
  Future<void> fetchAndSaveRoadsWaterSupplyData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlRoadsWaterSupplyWork);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      WaterFirstModel model = WaterFirstModel.fromMap(item);
      await dbClient.insert(tableNameRoadsWaterSupplyWork, model.toMap());
    }
  }
  Future<List<WaterFirstModel>> getUnPostedRoadsWaterSupplyWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameRoadsWaterSupplyWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<WaterFirstModel> waterFirst = maps.map((map) => WaterFirstModel.fromMap(map)).toList();
    return waterFirst;
  }
  Future<int>add(WaterFirstModel waterFirstModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameRoadsWaterSupplyWork,waterFirstModel.toMap());
  }

  Future<int>update(WaterFirstModel waterFirstModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameRoadsWaterSupplyWork,waterFirstModel.toMap(),
        where: 'id = ?', whereArgs: [waterFirstModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameRoadsWaterSupplyWork,
        where: 'id = ?', whereArgs: [id]);
  }
}