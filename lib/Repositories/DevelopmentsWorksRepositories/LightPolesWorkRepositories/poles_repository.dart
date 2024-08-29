

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_excavation_model.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_model.dart';
import 'package:flutter/foundation.dart';



class PolesRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PolesModel>> getPoles() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePoles,
        columns: ['id', 'blockNo', 'streetNo', 'totalLength','date']
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
    List<PolesModel> poles = [];
    for (int i = 0; i < maps.length; i++) {
      poles.add(PolesModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed PolesModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return poles;
  }



  Future<int>add(PolesModel polesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePoles,polesModel.toMap());
  }

  Future<int>update(PolesModel polesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePoles,polesModel.toMap(),
        where: 'id = ?', whereArgs: [polesModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePoles,
        where: 'id = ?', whereArgs: [id]);
  }
}