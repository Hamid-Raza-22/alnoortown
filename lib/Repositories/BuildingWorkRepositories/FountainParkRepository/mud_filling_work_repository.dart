

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/mud_filling_work_model.dart';
import 'package:flutter/foundation.dart';

class MudFillingWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MudFillingWorkModel>> getMudFillingWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMudFillingWorkFountainPark,
        columns: ['id', 'startDate', 'expectedCompDate','totalDumpers','mudFillingCompStatus','date','time']
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
    List<MudFillingWorkModel> mudFillingWork = [];
    for (int i = 0; i < maps.length; i++) {
      mudFillingWork.add(MudFillingWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MudFillingWorkModel objects:');
    }

    return mudFillingWork;
  }

  Future<int>add(MudFillingWorkModel mudFillingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMudFillingWorkFountainPark,mudFillingWorkModel.toMap());
  }

  Future<int>update(MudFillingWorkModel mudFillingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMudFillingWorkFountainPark,mudFillingWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mudFillingWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMudFillingWorkFountainPark,
        where: 'id = ?', whereArgs: [id]);
  }
}