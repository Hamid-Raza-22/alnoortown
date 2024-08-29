

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/tiles_work_model.dart';
import 'package:flutter/foundation.dart';

class TilesWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<TilesWorkModel>> getTilesWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameTiles,
        columns: ['id', 'blockNo', 'tilesWorkStatus','date']
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
    List<TilesWorkModel> tilesWork = [];
    for (int i = 0; i < maps.length; i++) {
      tilesWork.add(TilesWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed TilesWorkModel objects:');
    }

    return tilesWork;
  }

  Future<int>add(TilesWorkModel tilesWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameTiles,tilesWorkModel.toMap());
  }

  Future<int>update(TilesWorkModel tilesWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameTiles,tilesWorkModel.toMap(),
        where: 'id = ?', whereArgs: [tilesWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameTiles,
        where: 'id = ?', whereArgs: [id]);
  }
}