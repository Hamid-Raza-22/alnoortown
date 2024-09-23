

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
        tableNameCompactionAfterWaterBound,
        columns: ['id', 'block_no', 'roadNo','totalLength','startDate','expectedCompDate','waterBoundCompStatus','date','time','posted']
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
  Future<List<CompactionWaterBoundModel>> getUnPostedCompactionWaterBound() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameCompactionAfterWaterBound,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<CompactionWaterBoundModel> compactionWaterBound = maps.map((map) => CompactionWaterBoundModel.fromMap(map)).toList();
    return compactionWaterBound;
  }
  Future<int>add(CompactionWaterBoundModel compactionWaterBoundModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameCompactionAfterWaterBound,compactionWaterBoundModel.toMap());
  }

  Future<int>update(CompactionWaterBoundModel compactionWaterBoundModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameCompactionAfterWaterBound,compactionWaterBoundModel.toMap(),
        where: 'id = ?', whereArgs: [compactionWaterBoundModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameCompactionAfterWaterBound,
        where: 'id = ?', whereArgs: [id]);
  }
}