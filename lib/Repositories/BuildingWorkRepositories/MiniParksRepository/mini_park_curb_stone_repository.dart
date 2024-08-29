

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mini_park_curb_stone_model.dart';
import 'package:flutter/foundation.dart';

class MiniParkCurbStoneRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MiniParkCurbStoneModel>> getMiniParkCurbStone() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMpCurbStone,
        columns: ['id', 'startDate', 'expectedCompDate','mpCurbStoneCompStatus']
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
    List<MiniParkCurbStoneModel>  miniParkCurbStone= [];
    for (int i = 0; i < maps.length; i++) {
      miniParkCurbStone.add(MiniParkCurbStoneModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MiniParkCurbStoneModel objects:');
    }

    return miniParkCurbStone;
  }

  Future<int>add(MiniParkCurbStoneModel miniParkCurbStoneModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMpCurbStone,miniParkCurbStoneModel.toMap());
  }

  Future<int>update(MiniParkCurbStoneModel miniParkCurbStoneModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMpCurbStone,miniParkCurbStoneModel.toMap(),
        where: 'id = ?', whereArgs: [miniParkCurbStoneModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMpCurbStone,
        where: 'id = ?', whereArgs: [id]);
  }
}