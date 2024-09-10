import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/MaterialShiftingModels/shifting_work_model.dart';
import 'package:flutter/foundation.dart';

class ShiftingWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ShiftingWorkModel>> getShiftingWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameShiftingWork,
        columns: ['id', 'fromBlock', 'toBlock', 'numOfShift','date','time']
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
    List<ShiftingWorkModel> shiftingWork = [];
    for (int i = 0; i < maps.length; i++) {
      shiftingWork.add(ShiftingWorkModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed ShiftingWorkModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return shiftingWork;
  }



  Future<int>add(ShiftingWorkModel shiftingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameShiftingWork,shiftingWorkModel.toMap());
  }

  Future<int>update(ShiftingWorkModel shiftingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameShiftingWork,shiftingWorkModel.toMap(),
        where: 'id = ?', whereArgs: [shiftingWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameShiftingWork,
        where: 'id = ?', whereArgs: [id]);
  }
}