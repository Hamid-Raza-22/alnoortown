

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/cubstones_work_model.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../../Services/ApiServices/api_service.dart';

class CubStonesWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<CubStonesWorkModel>> getCubStonesWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameCurbStonesWork,
        columns: ['id', 'start_date', 'expected_comp_date','curbstones_comp_status','curbstones_work_date','time','posted','user_id']
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
    List<CubStonesWorkModel> cubStonesWork = [];
    for (int i = 0; i < maps.length; i++) {
      cubStonesWork.add(CubStonesWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed CubStonesWorkModel objects:');
    }

    return cubStonesWork;
  }
  Future<void> fetchAndSaveCurbStoneWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlCurbStonesWork);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      CubStonesWorkModel model = CubStonesWorkModel.fromMap(item);
      await dbClient.insert(tableNameCurbStonesWork, model.toMap());
    }
  }
  Future<List<CubStonesWorkModel>> getUnPostedCubStonesWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameCurbStonesWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<CubStonesWorkModel> cubStonesWork = maps.map((map) => CubStonesWorkModel.fromMap(map)).toList();
    return cubStonesWork;
  }
  Future<int>add(CubStonesWorkModel cubStonesWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameCurbStonesWork,cubStonesWorkModel.toMap());
  }

  Future<int>update(CubStonesWorkModel cubStonesWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameCurbStonesWork,cubStonesWorkModel.toMap(),
        where: 'id = ?', whereArgs: [cubStonesWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameCurbStonesWork,
        where: 'id = ?', whereArgs: [id]);
  }
}