

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/mg_plaster_work_model.dart';
import 'package:flutter/foundation.dart';

class MgPlasterWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MgPlasterWorkModel>> getMgPlasterWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePlasterWorkMainGate,
        columns:  ['id', 'block_no', 'workStatus','date','time','posted']
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

    // Convert the raw data into a list of
    List<MgPlasterWorkModel> mgPlasterWork = [];
    for (int i = 0; i < maps.length; i++) {
      mgPlasterWork.add(MgPlasterWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MgPlasterWorkModel objects:');
    }

    return mgPlasterWork;
  }

  Future<List<MgPlasterWorkModel>> getUnPostedMainGatePlaster() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePlasterWorkMainGate,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<MgPlasterWorkModel> mgPlasterWork = maps.map((map) => MgPlasterWorkModel.fromMap(map)).toList();
    return mgPlasterWork;
  }

  Future<int>add(MgPlasterWorkModel mgPlasterWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePlasterWorkMainGate,mgPlasterWorkModel.toMap());
  }

  Future<int>update(MgPlasterWorkModel mgPlasterWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePlasterWorkMainGate,mgPlasterWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mgPlasterWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePlasterWorkMainGate,
        where: 'id = ?', whereArgs: [id]);
  }
}