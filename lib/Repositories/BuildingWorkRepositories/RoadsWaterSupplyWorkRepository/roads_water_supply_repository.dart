

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsWaterSupplyWorkModel/roads_water_supply_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RoadsWaterSupplyRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<RoadsWaterSupplyModel>> getRoadsWaterSupply() async {
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
    List<RoadsWaterSupplyModel> roadsWaterSupply = [];
    for (int i = 0; i < maps.length; i++) {
      roadsWaterSupply.add(RoadsWaterSupplyModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed RoadsWaterSupplyModel objects:');
    }

    return roadsWaterSupply;
  }
  Future<void> fetchAndSaveRoadsWaterSupplyData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlRoadsWaterSupplyWork);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      RoadsWaterSupplyModel model = RoadsWaterSupplyModel.fromMap(item);
      await dbClient.insert(tableNameRoadsWaterSupplyWork, model.toMap());
    }
  }
  Future<List<RoadsWaterSupplyModel>> getUnPostedRoadsWaterSupplyWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameRoadsWaterSupplyWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<RoadsWaterSupplyModel> roadsWaterSupply = maps.map((map) => RoadsWaterSupplyModel.fromMap(map)).toList();
    return roadsWaterSupply;
  }
  Future<int>add(RoadsWaterSupplyModel roadsWaterSupplyModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameRoadsWaterSupplyWork,roadsWaterSupplyModel.toMap());
  }

  Future<int>update(RoadsWaterSupplyModel roadsWaterSupplyModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameRoadsWaterSupplyWork,roadsWaterSupplyModel.toMap(),
        where: 'id = ?', whereArgs: [roadsWaterSupplyModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameRoadsWaterSupplyWork,
        where: 'id = ?', whereArgs: [id]);
  }
}