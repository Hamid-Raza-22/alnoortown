

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/tanker_model.dart';
import 'package:flutter/foundation.dart';




class TankerRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<TankerModel>> getTanker() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameWaterTanker,
        columns: ['id', 'blockNo', 'streetNo', 'tankerNo','date','time']
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
    List<TankerModel> tanker = [];
    for (int i = 0; i < maps.length; i++) {
      tanker.add(TankerModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed TankerModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return tanker;
  }




  Future<int>add(TankerModel tankerModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameWaterTanker,tankerModel.toMap());
  }

  Future<int>update(TankerModel tankerModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameWaterTanker,tankerModel.toMap(),
        where: 'id = ?', whereArgs: [tankerModel.id]);

  }

  Future<int>delete(int? id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameWaterTanker,
        where: 'id = ?', whereArgs: [id]);
  }
}