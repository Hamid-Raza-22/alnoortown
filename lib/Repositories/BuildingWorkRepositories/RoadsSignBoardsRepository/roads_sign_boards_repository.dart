

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsSignBoardsModel/roads_sign_boards_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RoadsSignBoardsRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<RoadsSignBoardsModel>> getRoadsSignBoards() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameRoadsSignBoards,
        columns: ['id', 'block_no', 'roadNo','fromPlotNo','toPlotNo','roadSide','compStatus','roads_sign_boards_date','time','posted']
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
  Future<void> fetchAndSaveRoadsSignBoardsData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlRoadsSignBoards);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      RoadsSignBoardsModel model = RoadsSignBoardsModel.fromMap(item);
      await dbClient.insert(tableNameRoadsSignBoards, model.toMap());
    }
  }
  Future<List<RoadsSignBoardsModel>> getUnPostedMachines() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameRoadsSignBoards,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<RoadsSignBoardsModel> roadsSignBoards = maps.map((map) => RoadsSignBoardsModel.fromMap(map)).toList();
    return roadsSignBoards;
  }
  Future<int>add(RoadsSignBoardsModel roadsSignBoardsModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameRoadsSignBoards,roadsSignBoardsModel.toMap());
  }

  Future<int>update(RoadsSignBoardsModel roadsSignBoardsModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameRoadsSignBoards,roadsSignBoardsModel.toMap(),
        where: 'id = ?', whereArgs: [roadsSignBoardsModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameRoadsSignBoards,
        where: 'id = ?', whereArgs: [id]);
  }
}