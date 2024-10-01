import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsShoulderWorkModel/roads_shoulder_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RoadsShoulderWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<RoadsShoulderWorkModel>> getRoadsShoulderWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameRoadShoulder,
        columns: ['id', 'block_no', 'road_no','road_side','total_length','start_date','expected_comp_date','roads_shoulder_comp_status','roads_shoulder_date','time','posted','user_id']
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
    List<RoadsShoulderWorkModel> roadsShoulderWork = [];
    for (int i = 0; i < maps.length; i++) {
      roadsShoulderWork.add(RoadsShoulderWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed RoadsShoulderWorkModel objects:');
    }
    return roadsShoulderWork;
  }
  Future<void> fetchAndSaveRoadsShoulderWorkData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlRoadShoulder}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      RoadsShoulderWorkModel model = RoadsShoulderWorkModel.fromMap(item);
      await dbClient.insert(tableNameRoadShoulder, model.toMap());
    }
  }
  Future<List<RoadsShoulderWorkModel>> getUnPostedRoadsShoulder() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameRoadShoulder,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<RoadsShoulderWorkModel> roadsShoulderWork = maps.map((map) => RoadsShoulderWorkModel.fromMap(map)).toList();
    return roadsShoulderWork;
  }
  Future<int>add(RoadsShoulderWorkModel roadsShoulderWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameRoadShoulder,roadsShoulderWorkModel.toMap());
  }

  Future<int>update(RoadsShoulderWorkModel roadsShoulderWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameRoadShoulder,roadsShoulderWorkModel.toMap(),
        where: 'id = ?', whereArgs: [roadsShoulderWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameRoadShoulder,
        where: 'id = ?', whereArgs: [id]);
  }
}