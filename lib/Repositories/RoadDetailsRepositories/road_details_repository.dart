import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/RoadsDetailModels/roads_detail_models.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RoadDetailsRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<RoadsDetailModels>> getRoadsDetails() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameRoadsDetail,
        columns: ['id', 'phase', 'block','street','road_type','length']
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
    List<RoadsDetailModels> roadsDetail = [];
    for (int i = 0; i < maps.length; i++) {
      roadsDetail.add(RoadsDetailModels.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed RoadsDetailModels objects:');
    }

    return roadsDetail;
  }
  Future<void> fetchAndSaveRoadDetails() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlRoadsDetails);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      RoadsDetailModels model = RoadsDetailModels.fromMap(item);
      await dbClient.insert(tableNameRoadsDetail, model.toMap());
    }
  }

  Future<int>add(RoadsDetailModels roadsDetailModels) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameRoadsDetail,roadsDetailModels.toMap());
  }

  Future<int>update(RoadsDetailModels roadsDetailModels) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameRoadsDetail,roadsDetailModels.toMap(),
        where: 'id = ?', whereArgs: [roadsDetailModels.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameRoadsDetail,
        where: 'id = ?', whereArgs: [id]);
  }
}