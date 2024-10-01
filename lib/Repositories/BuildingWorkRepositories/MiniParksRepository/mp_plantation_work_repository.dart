import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mp_plantation_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class MpPlantationWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MpPlantationWorkModel>> getMpPlantationWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePlantationWorkMiniPark,
        columns: ['id', 'start_date', 'expected_comp_date','mini_park_plantation_comp_status','mini_park_plantation_date','time','posted','user_id']
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
    List<MpPlantationWorkModel>  mpPlantationWork= [];
    for (int i = 0; i < maps.length; i++) {
      mpPlantationWork.add(MpPlantationWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MpPlantationWorkModel objects:');
    }

    return mpPlantationWork;
  }
  Future<void> fetchAndSaveMiniParkPlantationData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlPlantationWorkMiniPark}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      MpPlantationWorkModel model = MpPlantationWorkModel.fromMap(item);
      await dbClient.insert(tableNamePlantationWorkMiniPark, model.toMap());
    }
  }
  Future<List<MpPlantationWorkModel>> getUnPostedPlantationWorkMp() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePlantationWorkMiniPark,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<MpPlantationWorkModel> mpPlantationWork = maps.map((map) => MpPlantationWorkModel.fromMap(map)).toList();
    return mpPlantationWork;
  }
  Future<int>add(MpPlantationWorkModel mpPlantationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePlantationWorkMiniPark,mpPlantationWorkModel.toMap());
  }

  Future<int>update(MpPlantationWorkModel mpPlantationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePlantationWorkMiniPark,mpPlantationWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mpPlantationWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePlantationWorkMiniPark,
        where: 'id = ?', whereArgs: [id]);
  }
}