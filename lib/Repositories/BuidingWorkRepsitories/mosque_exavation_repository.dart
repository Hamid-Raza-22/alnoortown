

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/mosque_exavation_work.dart';
import 'package:flutter/foundation.dart';




class MosqueExavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MosqueExavationWorkModel>> getMosqueExavation() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMosque,
        columns: ['id', 'blockNo', 'completionStatus', 'date']
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
    List<MosqueExavationWorkModel> mosqueExavationWork = [];
    for (int i = 0; i < maps.length; i++) {
      mosqueExavationWork.add(MosqueExavationWorkModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed MosqueExavationWorkModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return mosqueExavationWork;
  }


  Future<int>add(MosqueExavationWorkModel mosqueExavationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMosque,mosqueExavationWorkModel.toMap());
  }

  Future<int>update(MosqueExavationWorkModel mosqueExavationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMosque,mosqueExavationWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mosqueExavationWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMosque,
        where: 'id = ?', whereArgs: [id]);
  }
}