

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/boundary_grill_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class BoundaryGrillWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<BoundaryGrillWorkModel>> getBoundaryGrillWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameBoundaryGrillWork,
        columns: ['id', 'start_date', 'expected_comp_date','boundary_work_comp_status','boundary_grill_work_date','time','posted','user_id']
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
    List<BoundaryGrillWorkModel> boundaryGrillWork = [];
    for (int i = 0; i < maps.length; i++) {
      boundaryGrillWork.add(BoundaryGrillWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed BoundaryGrillWorkModel objects:');
    }

    return boundaryGrillWork;
  }
  Future<void> fetchAndSaveBoundaryGrillWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlBoundaryGrillWork);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      BoundaryGrillWorkModel model = BoundaryGrillWorkModel.fromMap(item);
      await dbClient.insert(tableNameBoundaryGrillWork, model.toMap());
    }
  }

  Future<List<BoundaryGrillWorkModel>> getUnPostedBoundaryGrill() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameBoundaryGrillWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<BoundaryGrillWorkModel> boundaryGrillWork = maps.map((map) => BoundaryGrillWorkModel.fromMap(map)).toList();
    return boundaryGrillWork;
  }
  Future<int>add(BoundaryGrillWorkModel boundaryGrillWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameBoundaryGrillWork,boundaryGrillWorkModel.toMap());
  }

  Future<int>update(BoundaryGrillWorkModel boundaryGrillWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameBoundaryGrillWork,boundaryGrillWorkModel.toMap(),
        where: 'id = ?', whereArgs: [boundaryGrillWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameBoundaryGrillWork,
        where: 'id = ?', whereArgs: [id]);
  }
}