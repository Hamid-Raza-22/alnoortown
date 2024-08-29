

import 'package:al_noor_town/Database/dbHelper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/ceiling_work_model.dart';
import 'package:flutter/foundation.dart';

class CeilingWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<CeilingWorkModel>> getCeilingWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameCeiling,
        columns: ['id', 'blockNo', 'ceilingWorkStatus','date']
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
    List<CeilingWorkModel> ceilingWork = [];
    for (int i = 0; i < maps.length; i++) {
      ceilingWork.add(CeilingWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed CeilingWorkModel objects:');
    }

    return ceilingWork;
  }

  Future<int>add(CeilingWorkModel ceilingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameCeiling,ceilingWorkModel.toMap());
  }

  Future<int>update(CeilingWorkModel ceilingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameCeiling,ceilingWorkModel.toMap(),
        where: 'id = ?', whereArgs: [ceilingWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameCeiling,
        where: 'id = ?', whereArgs: [id]);
  }
}