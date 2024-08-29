

import 'package:al_noor_town/Database/dbHelper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/main_gate_foundation_work_model.dart';
import 'package:flutter/foundation.dart';

class MainGateFoundationWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MainGateFoundationWorkModel>> getMainGateFoundationWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameGateFoundation,
        columns:  ['id', 'blockNo', 'workStatus','date']
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
    List<MainGateFoundationWorkModel> mainGateFoundationWork = [];
    for (int i = 0; i < maps.length; i++) {
      mainGateFoundationWork.add(MainGateFoundationWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MainGateFoundationWorkModel objects:');
    }

    return mainGateFoundationWork;
  }

  Future<int>add(MainGateFoundationWorkModel mainGateFoundationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameGateFoundation,mainGateFoundationWorkModel.toMap());
  }

  Future<int>update(MainGateFoundationWorkModel mainGateFoundationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameGateFoundation,mainGateFoundationWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mainGateFoundationWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameGateFoundation,
        where: 'id = ?', whereArgs: [id]);
  }
}