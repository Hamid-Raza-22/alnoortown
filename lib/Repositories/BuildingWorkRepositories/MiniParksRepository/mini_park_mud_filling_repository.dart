

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mini_park_mud_filling_model.dart';
import 'package:flutter/foundation.dart';

class MiniParkMudFillingRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MiniParkMudFillingModel>> getMiniParkMudFilling() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMpMud,
        columns: ['id', 'startDate', 'expectedCompDate','mpMudFillingCompStatus']
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
    List<MiniParkMudFillingModel>  miniParkMudFilling= [];
    for (int i = 0; i < maps.length; i++) {
      miniParkMudFilling.add(MiniParkMudFillingModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MiniParkMudFillingModel objects:');
    }

    return miniParkMudFilling;
  }

  Future<int>add(MiniParkMudFillingModel miniParkMudFillingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMpMud,miniParkMudFillingModel.toMap());
  }

  Future<int>update(MiniParkMudFillingModel miniParkMudFillingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMpMud,miniParkMudFillingModel.toMap(),
        where: 'id = ?', whereArgs: [miniParkMudFillingModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMpMud,
        where: 'id = ?', whereArgs: [id]);
  }
}