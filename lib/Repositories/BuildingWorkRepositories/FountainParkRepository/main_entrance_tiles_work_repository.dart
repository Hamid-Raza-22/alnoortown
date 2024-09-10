

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/main_entrance_tiles_work_model.dart';
import 'package:flutter/foundation.dart';

class MainEntranceTilesWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MainEntranceTilesWorkModel>> getMainEntranceTilesWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMainEntranceTilesWork,
        columns: ['id', 'startDate', 'expectedCompDate','mainEntranceTilesWorkCompStatus','date','time']
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