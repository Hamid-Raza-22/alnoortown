

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mp_plantation_work_model.dart';
import 'package:flutter/foundation.dart';

class MpPlantationWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MpPlantationWorkModel>> getMpPlantationWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMpPlant,
        columns: ['id', 'startDate', 'expectedCompDate','mpPCompStatus']
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
    List<MpPlantationWorkModel>  mpPlantationWork= [];
    for (int i = 0; i < maps.length; i++) {
      mpPlantationWork.add(MpPlantationWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MpPlantationWorkModel objects:');
    }

    return mpPlantationWork;
  }

  Future<int>add(MpPlantationWorkModel mpPlantationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMpPlant,mpPlantationWorkModel.toMap());
  }

  Future<int>update(MpPlantationWorkModel mpPlantationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMpPlant,mpPlantationWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mpPlantationWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMpPlant,
        where: 'id = ?', whereArgs: [id]);
  }
}