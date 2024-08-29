

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/sanitary_work_model.dart';
import 'package:flutter/foundation.dart';

class SanitaryWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<SanitaryWorkModel>> getSanitaryWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameSanitary,
        columns: ['id', 'blockNo', 'sanitaryWorkStatus','date']
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

    // Convert the raw data
    List<SanitaryWorkModel> sanitaryWork = [];
    for (int i = 0; i < maps.length; i++) {
      sanitaryWork.add(SanitaryWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed SanitaryWorkModel objects:');
    }

    return sanitaryWork;
  }

  Future<int>add(SanitaryWorkModel sanitaryWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameSanitary,sanitaryWorkModel.toMap());
  }

  Future<int>update(SanitaryWorkModel sanitaryWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameSanitary,sanitaryWorkModel.toMap(),
        where: 'id = ?', whereArgs: [sanitaryWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameSanitary,
        where: 'id = ?', whereArgs: [id]);
  }
}