

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/machine_model.dart';
import 'package:flutter/foundation.dart';


class MachineRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MachineModel>> getMachine() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMachine,
        columns: ['id', 'blockNo', 'streetNo', 'machine', 'timeIn', 'timeOut', 'date']
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
    List<MachineModel> machine = [];
    for (int i = 0; i < maps.length; i++) {
      machine.add(MachineModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed MachineModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return machine;
  }



  Future<int>add(MachineModel machineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMachine,machineModel.toMap());
  }

  Future<int>update(MachineModel machineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMachine,machineModel.toMap(),
        where: 'id = ?', whereArgs: [machineModel.id]);

  }

  Future<int>delete(int? id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMachine,
        where: 'id = ?', whereArgs: [id]);
  }
}