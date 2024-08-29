

import 'package:al_noor_town/Database/dbHelper.dart';
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
        tableNameBoundary,
        columns: ['id', 'startDate', 'expectedCompDate','boundaryWorkCompStatus']
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

  Future<int>add(BoundaryGrillWorkModel boundaryGrillWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameBoundary,boundaryGrillWorkModel.toMap());
  }

  Future<int>update(BoundaryGrillWorkModel boundaryGrillWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameBoundary,boundaryGrillWorkModel.toMap(),
        where: 'id = ?', whereArgs: [boundaryGrillWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameBoundary,
        where: 'id = ?', whereArgs: [id]);
  }
}