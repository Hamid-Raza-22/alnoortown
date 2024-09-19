

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/boundary_grill_work_model.dart';
import 'package:flutter/foundation.dart';

class BoundaryGrillWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<BoundaryGrillWorkModel>> getBoundaryGrillWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameBoundaryGrillWork,
        columns: ['id', 'startDate', 'expectedCompDate','boundaryWorkCompStatus','date','time','posted']
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
// Fetch all unposted machines (posted = 0)
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