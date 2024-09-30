

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/mud_filling_work_model.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../../Services/ApiServices/api_service.dart';

class MudFillingWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MudFillingWorkModel>> getMudFillingWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMudFillingWorkFountainPark,
        columns: ['id', 'start_date', 'expected_comp_date','total_dumpers','mud_filling_comp_status','mud_filling_date','time','posted','user_id']
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
    List<MudFillingWorkModel> mudFillingWork = [];
    for (int i = 0; i < maps.length; i++) {
      mudFillingWork.add(MudFillingWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MudFillingWorkModel objects:');
    }

    return mudFillingWork;
  }
  Future<void> fetchAndSaveMudFillingData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlMudFillingWorkFountainPark);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      MudFillingWorkModel model = MudFillingWorkModel.fromMap(item);
      await dbClient.insert(tableNameMudFillingWorkFountainPark, model.toMap());
    }
  }
  Future<List<MudFillingWorkModel>> getUnPostedMudFilling() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameMudFillingWorkFountainPark,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<MudFillingWorkModel> mudFillingWork = maps.map((map) => MudFillingWorkModel.fromMap(map)).toList();
    return mudFillingWork;
  }
  Future<int>add(MudFillingWorkModel mudFillingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMudFillingWorkFountainPark,mudFillingWorkModel.toMap());
  }

  Future<int>update(MudFillingWorkModel mudFillingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMudFillingWorkFountainPark,mudFillingWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mudFillingWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMudFillingWorkFountainPark,
        where: 'id = ?', whereArgs: [id]);
  }
}