

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/foundation_work_model.dart';
import 'package:flutter/foundation.dart';

class FoundationWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<FoundationWorkModel>> getFoundationWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameFoundationWorkMosque,
        columns: ['id', 'blockNo', 'brickWork','mudFiling','plasterWork','date','time','posted']
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
    List<FoundationWorkModel> foundationWork = [];
    for (int i = 0; i < maps.length; i++) {
      foundationWork.add(FoundationWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed FoundationWorkModel objects:');
    }

    return foundationWork;
  }
  Future<List<FoundationWorkModel>> getUnPostedFoundationWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameFoundationWorkMosque,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<FoundationWorkModel> foundationWork = maps.map((map) => FoundationWorkModel.fromMap(map)).toList();
    return foundationWork;
  }
  Future<int>add(FoundationWorkModel foundationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameFoundationWorkMosque,foundationWorkModel.toMap());
  }

  Future<int>update(FoundationWorkModel foundationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameFoundationWorkMosque,foundationWorkModel.toMap(),
        where: 'id = ?', whereArgs: [foundationWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameFoundationWorkMosque,
        where: 'id = ?', whereArgs: [id]);
  }
}