

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/base_sub_base_compaction_model.dart';
import 'package:flutter/foundation.dart';

class BaseSubBaseCompactionRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<BaseSubBaseCompactionModel>> getSubBaseCompaction() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameBaseSubBaseCompaction,
        columns: ['id', 'blockNo', 'roadNo','totalLength','startDate','expectedCompDate','baseSubBaseCompStatus','date','time','posted']
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
    List<BaseSubBaseCompactionModel>  baseSubBaseCompaction= [];
    for (int i = 0; i < maps.length; i++) {
      baseSubBaseCompaction.add(BaseSubBaseCompactionModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed BaseSubBaseCompactionModel objects:');
    }
    return baseSubBaseCompaction;
  }
  Future<List<BaseSubBaseCompactionModel>> getUnPostedBaseSubBase() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameBaseSubBaseCompaction,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<BaseSubBaseCompactionModel> baseSubBaseCompaction = maps.map((map) => BaseSubBaseCompactionModel.fromMap(map)).toList();
    return baseSubBaseCompaction;
  }
  Future<int>add(BaseSubBaseCompactionModel baseSubBaseCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameBaseSubBaseCompaction,baseSubBaseCompactionModel.toMap());
  }

  Future<int>update(BaseSubBaseCompactionModel baseSubBaseCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameBaseSubBaseCompaction,baseSubBaseCompactionModel.toMap(),
        where: 'id = ?', whereArgs: [baseSubBaseCompactionModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameBaseSubBaseCompaction,
        where: 'id = ?', whereArgs: [id]);
  }
}