

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/mosque_excavation_work.dart';
import 'package:flutter/foundation.dart';




class MosqueExcavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MosqueExcavationWorkModel>> getMosqueExcavation() async {
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

    // Convert the raw data into a list
    List<MosqueExcavationWorkModel> mosqueExavationWork = [];
    for (int i = 0; i < maps.length; i++) {
      mosqueExavationWork.add(MosqueExcavationWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed MosqueExavationWorkModel objects:');
    }


    return mosqueExavationWork;
  }


  Future<int>add(MosqueExcavationWorkModel mosqueExavationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMosque,mosqueExavationWorkModel.toMap());
  }

  Future<int>update(MosqueExcavationWorkModel mosqueExavationWorkModel) async{
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