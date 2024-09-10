

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mp_fancy_light_poles_model.dart';
import 'package:flutter/foundation.dart';

class MpFancyLightPolesRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MpFancyLightPolesModel>> getMpFancyLightPoles() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameFancyLightPolesMiniPark,
        columns: ['id', 'startDate', 'expectedCompDate','mpLCompStatus','date','time']
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
    List<MpFancyLightPolesModel>  mpFancyLightPoles= [];
    for (int i = 0; i < maps.length; i++) {
      mpFancyLightPoles.add(MpFancyLightPolesModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MpFancyLightPolesModel objects:');
    }

    return mpFancyLightPoles;
  }

  Future<int>add(MpFancyLightPolesModel mpFancyLightPolesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameFancyLightPolesMiniPark,mpFancyLightPolesModel.toMap());
  }

  Future<int>update(MpFancyLightPolesModel mpFancyLightPolesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameFancyLightPolesMiniPark,mpFancyLightPolesModel.toMap(),
        where: 'id = ?', whereArgs: [mpFancyLightPolesModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameFancyLightPolesMiniPark,
        where: 'id = ?', whereArgs: [id]);
  }
}