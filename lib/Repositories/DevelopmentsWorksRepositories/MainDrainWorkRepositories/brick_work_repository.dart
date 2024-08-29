

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/brick_work_model.dart';
import 'package:flutter/foundation.dart';



class BrickWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<BrickWorkModel>> getBrickWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameBrick,
        columns: ['id', 'blockNo', 'streetNo', 'completedLength','date']
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
    List<BrickWorkModel> brickWork = [];
    for (int i = 0; i < maps.length; i++) {
      brickWork.add(BrickWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed BrickWorkModel objects:');
    }
    return brickWork;
  }


  Future<int>add(BrickWorkModel brickWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameBrick,brickWorkModel.toMap());
  }

  Future<int>update(BrickWorkModel brickWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameBrick,brickWorkModel.toMap(),
        where: 'id = ?', whereArgs: [brickWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameBrick,
        where: 'id = ?', whereArgs: [id]);
  }
}