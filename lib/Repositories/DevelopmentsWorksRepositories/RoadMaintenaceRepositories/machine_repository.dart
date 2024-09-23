
import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
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
        columns: ['id', 'block_no', 'street_no', 'machine', 'timeIn', 'timeOut','date','time','posted']
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

    return machine;
  }
  Future<List<MachineModel>> getUnPostedMachines() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameMachine,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<MachineModel> machines = maps.map((map) => MachineModel.fromMap(map)).toList();
    return machines;
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