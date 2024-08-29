

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/plantation_work_model.dart';
import 'package:flutter/foundation.dart';

class PlantationWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PlantationWorkModel>> getPlantationWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePlant,
        columns: ['id', 'startDate', 'expectedCompDate','plantationCompStatus']
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
    List<PlantationWorkModel> plantationWork = [];
    for (int i = 0; i < maps.length; i++) {
      plantationWork.add(PlantationWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed PlantationWorkModel objects:');
    }

    return plantationWork;
  }

  Future<int>add(PlantationWorkModel plantationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePlant,plantationWorkModel.toMap());
  }

  Future<int>update(PlantationWorkModel plantationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePlant,plantationWorkModel.toMap(),
        where: 'id = ?', whereArgs: [plantationWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePlant,
        where: 'id = ?', whereArgs: [id]);
  }
}