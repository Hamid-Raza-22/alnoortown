

import 'package:al_noor_town/Database/dbHelper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/sand_compaction_model.dart';
import 'package:flutter/foundation.dart';

class SandCompactionRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<SandCompactionModel>> getSandCompaction() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameSandCompaction,
        columns: ['id', 'blockNo', 'roadNo','totalLength','startDate','expectedCompDate','sandCompStatus']
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
    List<SandCompactionModel>  sandCompaction= [];
    for (int i = 0; i < maps.length; i++) {
      sandCompaction.add(SandCompactionModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed SandCompactionModel objects:');
    }

    return sandCompaction;
  }

  Future<int>add(SandCompactionModel sandCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameSandCompaction,sandCompactionModel.toMap());
  }

  Future<int>update(SandCompactionModel sandCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameSandCompaction,sandCompactionModel.toMap(),
        where: 'id = ?', whereArgs: [sandCompactionModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameSandCompaction,
        where: 'id = ?', whereArgs: [id]);
  }
}