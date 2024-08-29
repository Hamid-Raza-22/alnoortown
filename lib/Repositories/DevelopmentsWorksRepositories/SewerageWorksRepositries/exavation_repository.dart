

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/exavation_model.dart';
import 'package:flutter/foundation.dart';

class ExavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ExavationModel>> getExavation() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameExavation,
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
    List<ExavationModel> exavation = [];
    for (int i = 0; i < maps.length; i++) {
      exavation.add(ExavationModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed ExavationModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return exavation;
  }




  Future<int>add(ExavationModel exavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameExavation,exavationModel.toMap());
  }

  Future<int>update(ExavationModel exavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameExavation,exavationModel.toMap(),
        where: 'id = ?', whereArgs: [exavationModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameExavation,
        where: 'id = ?', whereArgs: [id]);
  }
}