

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/light_wires_model.dart';
import 'package:flutter/foundation.dart';

class LightWiresRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<LightWiresModel>> getLightWires() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameLight,
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
    List<LightWiresModel> lightWires = [];
    for (int i = 0; i < maps.length; i++) {
      lightWires.add(LightWiresModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed LightWiresModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return lightWires;
  }



  Future<int>add(LightWiresModel lightWiresModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameLight,lightWiresModel.toMap());
  }

  Future<int>update(LightWiresModel lightWiresModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameLight,lightWiresModel.toMap(),
        where: 'id = ?', whereArgs: [lightWiresModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameLight,
        where: 'id = ?', whereArgs: [id]);
  }
}