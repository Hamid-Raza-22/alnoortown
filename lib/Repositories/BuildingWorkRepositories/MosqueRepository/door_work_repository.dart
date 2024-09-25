

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/doors_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class DoorWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<DoorsWorkModel>> getDoorWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameDoorsWorkMosque,
        columns: ['id', 'block_no', 'doorsWorkStatus','doors_work_date','time','posted']
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

    // Convert the raw data into a list
    List<DoorsWorkModel> doorsWork = [];
    for (int i = 0; i < maps.length; i++) {
      doorsWork.add(DoorsWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed DoorsWorkModel objects:');
    }

    return doorsWork;
  }
  Future<void> fetchAndSaveDoorsWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlDoorsWorkMosque);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      DoorsWorkModel model = DoorsWorkModel.fromMap(item);
      await dbClient.insert(tableNameDoorsWorkMosque, model.toMap());
    }
  }
  Future<List<DoorsWorkModel>> getUnPostedDoorsWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameDoorsWorkMosque,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<DoorsWorkModel> doorsWork = maps.map((map) => DoorsWorkModel.fromMap(map)).toList();
    return doorsWork;
  }
  Future<int>add(DoorsWorkModel doorsWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameDoorsWorkMosque,doorsWorkModel.toMap());
  }

  Future<int>update(DoorsWorkModel doorsWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameDoorsWorkMosque,doorsWorkModel.toMap(),
        where: 'id = ?', whereArgs: [doorsWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameDoorsWorkMosque,
        where: 'id = ?', whereArgs: [id]);
  }
}