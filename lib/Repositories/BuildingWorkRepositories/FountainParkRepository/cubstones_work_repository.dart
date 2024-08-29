

import 'package:al_noor_town/Database/dbHelper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/cubstones_work_model.dart';
import 'package:flutter/foundation.dart';

class CubStonesWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<CubStonesWorkModel>> getCubStonesWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameCubStone,
        columns: ['id', 'startDate', 'expectedCompDate','cubStonesCompStatus']
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
    List<CubStonesWorkModel> cubStonesWork = [];
    for (int i = 0; i < maps.length; i++) {
      cubStonesWork.add(CubStonesWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed CubStonesWorkModel objects:');
    }

    return cubStonesWork;
  }

  Future<int>add(CubStonesWorkModel cubStonesWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameCubStone,cubStonesWorkModel.toMap());
  }

  Future<int>update(CubStonesWorkModel cubStonesWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameCubStone,cubStonesWorkModel.toMap(),
        where: 'id = ?', whereArgs: [cubStonesWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameCubStone,
        where: 'id = ?', whereArgs: [id]);
  }
}