

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsEdgingWorkModel/roads_edging_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RoadsEdgingWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<RoadsEdgingWorkModel>> getRoadsEdgingWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameRoadsEdging,
        columns: ['id', 'block_no', 'road_no','road_side','total_length','start_date','expected_comp_date','roads_edging_comp_status','roads_edging_date','time','posted','user_id']
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
    List<RoadsEdgingWorkModel> roadsEdgingWork = [];
    for (int i = 0; i < maps.length; i++) {
      roadsEdgingWork.add(RoadsEdgingWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed RoadsEdgingWorkModel objects:');
    }

    return roadsEdgingWork;
  }
  Future<void> fetchAndSaveRoadsEdgingWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlRoadsEdging);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      RoadsEdgingWorkModel model = RoadsEdgingWorkModel.fromMap(item);
      await dbClient.insert(tableNameRoadsEdging, model.toMap());
    }
  }
  Future<List<RoadsEdgingWorkModel>> getUnPostedRoadsEdging() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameRoadsEdging,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<RoadsEdgingWorkModel> roadsEdgingWork = maps.map((map) => RoadsEdgingWorkModel.fromMap(map)).toList();
    return roadsEdgingWork;
  }
  Future<int>add(RoadsEdgingWorkModel roadsEdgingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameRoadsEdging,roadsEdgingWorkModel.toMap());
  }

  Future<int>update(RoadsEdgingWorkModel roadsEdgingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameRoadsEdging,roadsEdgingWorkModel.toMap(),
        where: 'id = ?', whereArgs: [roadsEdgingWorkModel.id]);
  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameRoadsEdging,
        where: 'id = ?', whereArgs: [id]);
  }
}