

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/asphalt_work_model.dart';
import 'package:flutter/foundation.dart';




class AsphaltWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<AsphaltWorkModel>> getAsphaltWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameAsphalt,
        columns: ['id', 'blockNo', 'streetNo', 'tankerNo']
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
    List<AsphaltWorkModel> asphaltWork = [];
    for (int i = 0; i < maps.length; i++) {
      asphaltWork.add(AsphaltWorkModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed AsphaltWorkModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return asphaltWork;
  }





  Future<int>add(AsphaltWorkModel asphaltWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameAsphalt,asphaltWorkModel.toMap());
  }

  Future<int>update(AsphaltWorkModel asphaltWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameAsphalt,asphaltWorkModel.toMap(),
        where: 'id = ?', whereArgs: [asphaltWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameAsphalt,
        where: 'id = ?', whereArgs: [id]);
  }
}