

import 'package:al_noor_town/Database/db_helper.dart';

import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_excavation_model.dart';
import 'package:flutter/foundation.dart';

import '../../../Globals/globals.dart';




class PolesExcavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PolesExcavationModel>> getPolesExcavation() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePolesExcavation,
        columns: ['id', 'blockNo', 'streetNo', 'noOfExcavation','date','time']
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
    List<PolesExcavationModel> polesExcavation = [];
    for (int i = 0; i < maps.length; i++) {
      polesExcavation.add(PolesExcavationModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed PolesExcavationModel objects:');
    }


    return polesExcavation;
  }




  Future<int>add(PolesExcavationModel polesExcavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePolesExcavation,polesExcavationModel.toMap());
  }

  Future<int>update(PolesExcavationModel polesExcavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePolesExcavation,polesExcavationModel.toMap(),
        where: 'id = ?', whereArgs: [polesExcavationModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePolesExcavation,
        where: 'id = ?', whereArgs: [id]);
  }
}