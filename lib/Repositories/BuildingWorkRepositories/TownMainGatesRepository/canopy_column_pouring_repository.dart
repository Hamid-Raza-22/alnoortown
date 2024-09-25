

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/canopy_column_pouring_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class CanopyColumnPouringRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<CanopyColumnPouringModel>> getCanopyColumnPouring() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMainGateCanopyColumnPouringWork,
        columns: ['id', 'block_no', 'work_status','canopy_column_pouring_main_gate_date','time','posted']
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
    List<CanopyColumnPouringModel> canopyColumnPouring = [];
    for (int i = 0; i < maps.length; i++) {
      canopyColumnPouring.add(CanopyColumnPouringModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed CanopyColumnPouringModel objects:');
    }

    return canopyColumnPouring;
  }
  Future<void> fetchAndSaveCanopyColumnData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlMainGateCanopyColumnPouringWork);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      CanopyColumnPouringModel model = CanopyColumnPouringModel.fromMap(item);
      await dbClient.insert(tableNameMainGateCanopyColumnPouringWork, model.toMap());
    }
  }
  Future<List<CanopyColumnPouringModel>> getUnPostedCanopyColumnPouring() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameMainGateCanopyColumnPouringWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<CanopyColumnPouringModel> canopyColumnPouring = maps.map((map) => CanopyColumnPouringModel.fromMap(map)).toList();
    return canopyColumnPouring;
  }
  Future<int>add(CanopyColumnPouringModel canopyColumnPouringModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMainGateCanopyColumnPouringWork,canopyColumnPouringModel.toMap());
  }

  Future<int>update(CanopyColumnPouringModel canopyColumnPouringModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMainGateCanopyColumnPouringWork,canopyColumnPouringModel.toMap(),
        where: 'id = ?', whereArgs: [canopyColumnPouringModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMainGateCanopyColumnPouringWork,
        where: 'id = ?', whereArgs: [id]);
  }
}