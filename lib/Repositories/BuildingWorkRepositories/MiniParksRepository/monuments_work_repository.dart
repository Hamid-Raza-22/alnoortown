import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/monuments_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class MonumentsWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MonumentsWorkModel>> getMonumentsWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMonumentWork,
        columns: ['id', 'start_date', 'expected_comp_date','monuments_work_comp_status','monuments_date','time','posted','user_id']
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
    List<MonumentsWorkModel>  monumentsWork= [];
    for (int i = 0; i < maps.length; i++) {
      monumentsWork.add(MonumentsWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MonumentsWorkModel objects:');
    }

    return monumentsWork;
  }
  Future<void> fetchAndSaveMonumentWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlMonumentWork);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      MonumentsWorkModel model = MonumentsWorkModel.fromMap(item);
      await dbClient.insert(tableNameMonumentWork, model.toMap());
    }
  }
  Future<List<MonumentsWorkModel>> getUnPostedMonumentWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameMonumentWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<MonumentsWorkModel> monumentsWork = maps.map((map) => MonumentsWorkModel.fromMap(map)).toList();
    return monumentsWork;
  }
  Future<int>add(MonumentsWorkModel monumentsWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMonumentWork,monumentsWorkModel.toMap());
  }

  Future<int>update(MonumentsWorkModel monumentsWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMonumentWork,monumentsWorkModel.toMap(),
        where: 'id = ?', whereArgs: [monumentsWorkModel.id]);
  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMonumentWork,
        where: 'id = ?', whereArgs: [id]);
  }
}