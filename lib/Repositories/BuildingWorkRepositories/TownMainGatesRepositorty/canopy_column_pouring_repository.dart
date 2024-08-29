

import 'package:al_noor_town/Database/dbHelper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/canopy_column_pouring_model.dart';
import 'package:flutter/foundation.dart';

class CanopyColumnPouringRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<CanopyColumnPouringModel>> getCanopyColumnPouring() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameCanopy,
        columns: ['id', 'blockNo', 'workStatus','date']
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
    List<CanopyColumnPouringModel> canopyColumnPouring = [];
    for (int i = 0; i < maps.length; i++) {
      canopyColumnPouring.add(CanopyColumnPouringModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed CanopyColumnPouringModel objects:');
    }

    return canopyColumnPouring;
  }

  Future<int>add(CanopyColumnPouringModel canopyColumnPouringModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameCanopy,canopyColumnPouringModel.toMap());
  }

  Future<int>update(CanopyColumnPouringModel canopyColumnPouringModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameCanopy,canopyColumnPouringModel.toMap(),
        where: 'id = ?', whereArgs: [canopyColumnPouringModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameCanopy,
        where: 'id = ?', whereArgs: [id]);
  }
}