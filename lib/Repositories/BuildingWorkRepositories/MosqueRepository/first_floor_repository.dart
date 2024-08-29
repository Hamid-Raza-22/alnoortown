

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/first_floor_model.dart';
import 'package:flutter/foundation.dart';

class FirstFloorRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<FirstFloorModel>> getFirstFloor() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameFloor,
        columns: ['id', 'blockNo', 'brickWork','mudFiling','plasterWork','date']
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
    List<FirstFloorModel> firstFloor = [];
    for (int i = 0; i < maps.length; i++) {
      firstFloor.add(FirstFloorModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed FirstFloorModel objects:');
    }

    return firstFloor;
  }

  Future<int>add(FirstFloorModel firstFloorModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameFloor,firstFloorModel.toMap());
  }

  Future<int>update(FirstFloorModel firstFloorModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameFloor,firstFloorModel.toMap(),
        where: 'id = ?', whereArgs: [firstFloorModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameFloor,
        where: 'id = ?', whereArgs: [id]);
  }
}