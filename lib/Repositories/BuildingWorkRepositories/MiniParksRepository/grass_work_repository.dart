

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/grass_work_model.dart';
import 'package:flutter/foundation.dart';

class GrassWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<GrassWorkModel>> getGrassWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMpGrass,
        columns: ['id', 'startDate', 'expectedCompDate','grassWorkCompStatus','date','time']
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

  Future<int>add(GrassWorkModel grassWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMpGrass,grassWorkModel.toMap());
  }

  Future<int>update(GrassWorkModel grassWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMpGrass,grassWorkModel.toMap(),
        where: 'id = ?', whereArgs: [grassWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMpGrass,
        where: 'id = ?', whereArgs: [id]);
  }
}