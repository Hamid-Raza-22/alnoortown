

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/shuttering_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../../Services/FirebaseServices/firebase_remote_config.dart';

class ShutteringWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ShutteringWorkModel>> getShutteringWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameShutteringWork,
        columns: ['id', 'block_no', 'street_no', 'completed_length','shuttering_work_date','time','posted']
    );

    if (kDebugMode) {
      print('Raw data from database:');
    }
    for (var map in maps) {
      if (kDebugMode) {
        print(map);
      }
    }

    List<ShutteringWorkModel> shutteringWork = [];
    for (int i = 0; i < maps.length; i++) {
      shutteringWork.add(ShutteringWorkModel.fromMap(maps[i]));
    }
    if (kDebugMode) {
      print('Parsed ShutteringWorkModel objects:');
    }
    return shutteringWork;
  }
  Future<void> fetchAndSaveShutteringWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlShutteringWork);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      ShutteringWorkModel model = ShutteringWorkModel.fromMap(item);
      await dbClient.insert(tableNameShutteringWork, model.toMap());
    }
  }
  Future<List<ShutteringWorkModel>> getUnPostedShutteringWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameShutteringWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<ShutteringWorkModel> shutteringWork = maps.map((map) => ShutteringWorkModel.fromMap(map)).toList();
    return shutteringWork;
  }
  Future<int>add(ShutteringWorkModel shutteringWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameShutteringWork,shutteringWorkModel.toMap());
  }

  Future<int>update(ShutteringWorkModel shutteringWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameShutteringWork,shutteringWorkModel.toMap(),
        where: 'id = ?', whereArgs: [shutteringWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameShutteringWork,
        where: 'id = ?', whereArgs: [id]);
  }
}