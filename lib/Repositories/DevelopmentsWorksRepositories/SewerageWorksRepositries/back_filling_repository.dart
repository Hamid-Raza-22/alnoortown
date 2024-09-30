

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/back_filing_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../../Services/FirebaseServices/firebase_remote_config.dart';

class BackFillingRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<BackFilingModel>> getFiling() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameBackFiling,
        columns: ['id', 'block_no', 'street_no', 'status','back_filling_date','time','posted','user_id']
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

    // Convert the raw data into a list of MachineModel objects
    List<BackFilingModel> backFiling = [];
    for (int i = 0; i < maps.length; i++) {
      backFiling.add(BackFilingModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed BackFilingModel objects:');
    }

    return backFiling;
  }
  Future<void> fetchAndSaveBackFillingData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlBackFiling);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      BackFilingModel model = BackFilingModel.fromMap(item);
      await dbClient.insert(tableNameBackFiling, model.toMap());
    }
  }
  Future<List<BackFilingModel>> getUnPostedBackFilling() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameBackFiling,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<BackFilingModel> backFiling = maps.map((map) => BackFilingModel.fromMap(map)).toList();
    return backFiling;
  }
  Future<int>add(BackFilingModel backFilingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameBackFiling,backFilingModel.toMap());
  }

  Future<int>update(BackFilingModel backFilingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameBackFiling,backFilingModel.toMap(),
        where: 'id = ?', whereArgs: [backFilingModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameBackFiling,
        where: 'id = ?', whereArgs: [id]);
  }
}