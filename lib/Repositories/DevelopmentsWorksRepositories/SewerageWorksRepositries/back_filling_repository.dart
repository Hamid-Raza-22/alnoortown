

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/back_filing_model.dart';
import 'package:flutter/foundation.dart';




class BackFillingRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<BackFilingModel>> getFiling() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameBackFiling,
        columns: ['id', 'blockNo', 'streetNo', 'status','date','time']
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

    // Convert the raw data into a list of MachineModel objects
    List<BackFilingModel> backFiling = [];
    for (int i = 0; i < maps.length; i++) {
      backFiling.add(BackFilingModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed BackFilingModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return backFiling;
  }


  Future<int>add(BackFilingModel backFilingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameBackFiling,backFilingModel.toMap());
  }

  Future<int>update(BackFilingModel backFilingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameBackFiling,backFilingModel.toMap(),
        where: 'id = ?', whereArgs: [backFilingModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameBackFiling,
        where: 'id = ?', whereArgs: [id]);
  }
}