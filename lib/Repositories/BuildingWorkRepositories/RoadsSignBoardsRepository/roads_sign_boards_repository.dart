

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsSignBoardsModel/roads_sign_boards_model.dart';
import 'package:flutter/foundation.dart';

class RoadsSignBoardsRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<RoadsSignBoardsModel>> getRoadsSignBoards() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameRoadSB,
        columns: ['id', 'blockNo', 'roadNo','fromPlotNo','toPlotNo','roadSide','compStatus','date','time']
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
    List<RoadsSignBoardsModel> roadsSignBoards = [];
    for (int i = 0; i < maps.length; i++) {
      roadsSignBoards.add(RoadsSignBoardsModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed RoadsSignBoardsModel objects:');
    }

    return roadsSignBoards;
  }

  Future<int>add(RoadsSignBoardsModel roadsSignBoardsModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameRoadSB,roadsSignBoardsModel.toMap());
  }

  Future<int>update(RoadsSignBoardsModel roadsSignBoardsModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameRoadSB,roadsSignBoardsModel.toMap(),
        where: 'id = ?', whereArgs: [roadsSignBoardsModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameRoadSB,
        where: 'id = ?', whereArgs: [id]);
  }
}