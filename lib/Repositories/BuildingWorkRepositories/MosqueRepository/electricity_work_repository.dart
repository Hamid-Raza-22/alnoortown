

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/electricity_work_model.dart';
import 'package:flutter/foundation.dart';

class ElectricityWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ElectricityWorkModel>> getElectricityWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameElectricityWorkMosque,
        columns: ['id', 'block_no', 'electricityWorkStatus','date','time','posted']
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
    List<ElectricityWorkModel> electricityWork = [];
    for (int i = 0; i < maps.length; i++) {
      electricityWork.add(ElectricityWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed ElectricityWorkModel objects:');
    }

    return electricityWork;
  }
  Future<List<ElectricityWorkModel>> getUnPostedElectricityWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameElectricityWorkMosque,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<ElectricityWorkModel> electricityWork = maps.map((map) => ElectricityWorkModel.fromMap(map)).toList();
    return electricityWork;
  }
  Future<int>add(ElectricityWorkModel electricityWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameElectricityWorkMosque,electricityWorkModel.toMap());
  }

  Future<int>update(ElectricityWorkModel electricityWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameElectricityWorkMosque,electricityWorkModel.toMap(),
        where: 'id = ?', whereArgs: [electricityWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameElectricityWorkMosque,
        where: 'id = ?', whereArgs: [id]);
  }
}