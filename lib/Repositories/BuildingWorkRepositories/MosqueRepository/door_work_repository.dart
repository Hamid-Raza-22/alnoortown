

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/doors_work_model.dart';
import 'package:flutter/foundation.dart';

class DoorWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<DoorsWorkModel>> getDoorWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameDoor,
        columns: ['id', 'blockNo', 'doorsWorkStatus','date']
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
    List<DoorsWorkModel> doorsWork = [];
    for (int i = 0; i < maps.length; i++) {
      doorsWork.add(DoorsWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed DoorsWorkModel objects:');
    }

    return doorsWork;
  }

  Future<int>add(DoorsWorkModel doorsWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameDoor,doorsWorkModel.toMap());
  }

  Future<int>update(DoorsWorkModel doorsWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameDoor,doorsWorkModel.toMap(),
        where: 'id = ?', whereArgs: [doorsWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameDoor,
        where: 'id = ?', whereArgs: [id]);
  }
}