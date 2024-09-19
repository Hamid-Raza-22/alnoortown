

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/shuttering_work_model.dart';
import 'package:flutter/foundation.dart';

class ShutteringWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ShutteringWorkModel>> getShutteringWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameShutteringWork,
        columns: ['id', 'blockNo', 'streetNo', 'completedLength','date','time','posted']
    );

    if (kDebugMode) {
      print('Raw data from database:');
    }
    for (var map in maps) {
      if (kDebugMode) {
        print(map);
      }
    }

    List<ShutteringWorkModel> shutteringWork = [];
    for (int i = 0; i < maps.length; i++) {
      shutteringWork.add(ShutteringWorkModel.fromMap(maps[i]));
    }
    if (kDebugMode) {
      print('Parsed ShutteringWorkModel objects:');
    }
    return shutteringWork;
  }
  Future<List<ShutteringWorkModel>> getUnPostedShutteringWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameShutteringWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<ShutteringWorkModel> shutteringWork = maps.map((map) => ShutteringWorkModel.fromMap(map)).toList();
    return shutteringWork;
  }
  Future<int>add(ShutteringWorkModel shutteringWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameShutteringWork,shutteringWorkModel.toMap());
  }

  Future<int>update(ShutteringWorkModel shutteringWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameShutteringWork,shutteringWorkModel.toMap(),
        where: 'id = ?', whereArgs: [shutteringWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameShutteringWork,
        where: 'id = ?', whereArgs: [id]);
  }
}