
import 'package:al_noor_town/Database/db_helper.dart';
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
        tableNameFoundationWorkMainGate,
        columns:  ['id', 'block_no', 'workStatus','date','time','posted']
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
  Future<List<MainGateFoundationWorkModel>> getUnPostedMainGateFoundation() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameFoundationWorkMainGate,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<MainGateFoundationWorkModel> mainGateFoundationWork = maps.map((map) => MainGateFoundationWorkModel.fromMap(map)).toList();
    return mainGateFoundationWork;
  }
  Future<int>add(MainGateFoundationWorkModel mainGateFoundationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameFoundationWorkMainGate,mainGateFoundationWorkModel.toMap());
  }

  Future<int>update(MainGateFoundationWorkModel mainGateFoundationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameFoundationWorkMainGate,mainGateFoundationWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mainGateFoundationWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameFoundationWorkMainGate,
        where: 'id = ?', whereArgs: [id]);
  }
}