

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/shuttering_work_model.dart';
import 'package:flutter/foundation.dart';



class ShutteringWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ShutteringWorkModel>> getShutteringWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameShuttering,
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
    List<ShutteringWorkModel> shutteringWork = [];
    for (int i = 0; i < maps.length; i++) {
      shutteringWork.add(ShutteringWorkModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed ShutteringWorkModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return shutteringWork;
  }

  Future<int>add(ShutteringWorkModel shutteringWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameDrain,shutteringWorkModel.toMap());
  }

  Future<int>update(ShutteringWorkModel shutteringWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameDrain,shutteringWorkModel.toMap(),
        where: 'id = ?', whereArgs: [shutteringWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameShuttering,
        where: 'id = ?', whereArgs: [id]);
  }
}