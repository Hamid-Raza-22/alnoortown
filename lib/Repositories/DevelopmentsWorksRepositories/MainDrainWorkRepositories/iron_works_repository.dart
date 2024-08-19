

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/iron_works_model.dart';
import 'package:flutter/foundation.dart';




class IronWorksRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<IronWorksModel>> getIronWorks() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameIron,
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
    List<IronWorksModel> ironWorks = [];
    for (int i = 0; i < maps.length; i++) {
      ironWorks.add(IronWorksModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed IronWorksModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return ironWorks;
  }



  Future<int>add(IronWorksModel ironWorksModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameIron,ironWorksModel.toMap());
  }

  Future<int>update(IronWorksModel ironWorksModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameIron,ironWorksModel.toMap(),
        where: 'id = ?', whereArgs: [ironWorksModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameIron,
        where: 'id = ?', whereArgs: [id]);
  }
}