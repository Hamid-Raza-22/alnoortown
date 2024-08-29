

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_exavation_model.dart';
import 'package:flutter/foundation.dart';




class PolesExavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PolesExavationModel>> getPolesExavation() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePolesExavation,
        columns: ['id', 'blockNo', 'streetNo', 'lengthTotal','date']
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
    List<PolesExavationModel> polesExavation = [];
    for (int i = 0; i < maps.length; i++) {
      polesExavation.add(PolesExavationModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed TankerModel objects:');
    }


    return polesExavation;
  }




  Future<int>add(PolesExavationModel polesExavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePolesExavation,polesExavationModel.toMap());
  }

  Future<int>update(PolesExavationModel polesExavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePolesExavation,polesExavationModel.toMap(),
        where: 'id = ?', whereArgs: [polesExavationModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePolesExavation,
        where: 'id = ?', whereArgs: [id]);
  }
}