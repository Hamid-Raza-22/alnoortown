

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/manholes_model.dart';
import 'package:flutter/foundation.dart';

class ManholesRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ManholesModel>> getManholes() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameManholes,
        columns: ['id', 'blockNo', 'streetNo', 'length','date']
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
    List<ManholesModel> manholes = [];
    for (int i = 0; i < maps.length; i++) {
      manholes.add(ManholesModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed ManholesModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return manholes;
  }




  Future<int>add(ManholesModel manholesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameManholes,manholesModel.toMap());
  }

  Future<int>update(ManholesModel manholesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameManholes,manholesModel.toMap(),
        where: 'id = ?', whereArgs: [manholesModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameManholes,
        where: 'id = ?', whereArgs: [id]);
  }
}