import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/main_entrance_tiles_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class MainEntranceTilesWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MainEntranceTilesWorkModel>> getMainEntranceTilesWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMainEntranceTilesWork,
        columns: ['id', 'start_date', 'expected_comp_date','main_entrance_tiles_work_comp_status','main_entrance_tiles_date','time','posted','user_id']
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
    List<MainEntranceTilesWorkModel> mainEntranceTilesWork = [];
    for (int i = 0; i < maps.length; i++) {
      mainEntranceTilesWork.add(MainEntranceTilesWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MainEntranceTilesWorkModel objects:');
    }

    return mainEntranceTilesWork;
  }
  Future<void> fetchAndSaveMainEntranceTilesWorkData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlMainEntranceTilesWork}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      MainEntranceTilesWorkModel model = MainEntranceTilesWorkModel.fromMap(item);
      await dbClient.insert(tableNameMainEntranceTilesWork, model.toMap());
    }
  }
  Future<List<MainEntranceTilesWorkModel>> getUnPostedMainEntranceTiles() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameMainEntranceTilesWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<MainEntranceTilesWorkModel> mainEntranceTilesWork = maps.map((map) => MainEntranceTilesWorkModel.fromMap(map)).toList();
    return mainEntranceTilesWork;
  }
  Future<int>add(MainEntranceTilesWorkModel mainEntranceTilesWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMainEntranceTilesWork,mainEntranceTilesWorkModel.toMap());
  }

  Future<int>update(MainEntranceTilesWorkModel mainEntranceTilesWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMainEntranceTilesWork,mainEntranceTilesWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mainEntranceTilesWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMainEntranceTilesWork,
        where: 'id = ?', whereArgs: [id]);
  }
}