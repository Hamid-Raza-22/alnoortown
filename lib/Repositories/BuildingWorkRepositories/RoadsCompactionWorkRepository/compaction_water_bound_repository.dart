

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/compaction_water_bound_model.dart';
import 'package:flutter/foundation.dart';

class CompactionWaterBoundRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<CompactionWaterBoundModel>> getCompactionWaterBound() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameCWaterBound,
        columns: ['id', 'blockNo', 'roadNo','totalLength','startDate','expectedCompDate','waterBoundCompStatus']
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
    List<CompactionWaterBoundModel>  compactionWaterBound= [];
    for (int i = 0; i < maps.length; i++) {
      compactionWaterBound.add(CompactionWaterBoundModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed CompactionWaterBoundModel objects:');
    }

    return compactionWaterBound;
  }

  Future<int>add(CompactionWaterBoundModel compactionWaterBoundModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameCWaterBound,compactionWaterBoundModel.toMap());
  }

  Future<int>update(CompactionWaterBoundModel compactionWaterBoundModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameCWaterBound,compactionWaterBoundModel.toMap(),
        where: 'id = ?', whereArgs: [compactionWaterBoundModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameCWaterBound,
        where: 'id = ?', whereArgs: [id]);
  }
}