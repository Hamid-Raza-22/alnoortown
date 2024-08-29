

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
        tableNameSubBase,
        columns: ['id', 'blockNo', 'roadNo','totalLength','startDate','expectedCompDate','baseSubBaseCompStatus']
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

  Future<int>add(BaseSubBaseCompactionModel baseSubBaseCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameSubBase,baseSubBaseCompactionModel.toMap());
  }

  Future<int>update(BaseSubBaseCompactionModel baseSubBaseCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameSubBase,baseSubBaseCompactionModel.toMap(),
        where: 'id = ?', whereArgs: [baseSubBaseCompactionModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameSubBase,
        where: 'id = ?', whereArgs: [id]);
  }
}