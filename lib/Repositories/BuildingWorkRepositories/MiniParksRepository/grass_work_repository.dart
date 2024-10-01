import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/grass_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class GrassWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<GrassWorkModel>> getGrassWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameGrassWorkMiniPark,
        columns: ['id', 'start_date', 'expected_comp_date','grass_work_comp_status','grass_work_date','time','posted','user_id']
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
    List<GrassWorkModel>  grassWork= [];
    for (int i = 0; i < maps.length; i++) {
      grassWork.add(GrassWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed GrassWorkModel objects:');
    }

    return grassWork;
  }
  Future<void> fetchAndSaveGrassWorkData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlGrassWorkMiniPark}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      GrassWorkModel model = GrassWorkModel.fromMap(item);
      await dbClient.insert(tableNameGrassWorkMiniPark, model.toMap());
    }
  }
  Future<List<GrassWorkModel>> getUnPostedGrassWorkMp() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameGrassWorkMiniPark,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<GrassWorkModel> grassWork = maps.map((map) => GrassWorkModel.fromMap(map)).toList();
    return grassWork;
  }
  Future<int>add(GrassWorkModel grassWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameGrassWorkMiniPark,grassWorkModel.toMap());
  }

  Future<int>update(GrassWorkModel grassWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameGrassWorkMiniPark,grassWorkModel.toMap(),
        where: 'id = ?', whereArgs: [grassWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameGrassWorkMiniPark,
        where: 'id = ?', whereArgs: [id]);
  }
}