

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/mg_grey_structure_model.dart';
import 'package:flutter/foundation.dart';

class MgGreyStructureRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MgGreyStructureModel>> getMgGreyStructure() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameGreyStructureMainGate,
        columns:  ['id', 'blockNo', 'workStatus','date','time']
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
    List<MgGreyStructureModel> mgGreyStructure = [];
    for (int i = 0; i < maps.length; i++) {
      mgGreyStructure.add(MgGreyStructureModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MgGreyStructureModel objects:');
    }

    return mgGreyStructure;
  }

  Future<int>add(MgGreyStructureModel mgGreyStructureModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameGreyStructureMainGate,mgGreyStructureModel.toMap());
  }

  Future<int>update(MgGreyStructureModel mgGreyStructureModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameGreyStructureMainGate,mgGreyStructureModel.toMap(),
        where: 'id = ?', whereArgs: [mgGreyStructureModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameGreyStructureMainGate,
        where: 'id = ?', whereArgs: [id]);
  }
}