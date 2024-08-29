

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/walking_tracks_work_model.dart';
import 'package:flutter/foundation.dart';

class WalkingTracksWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<WalkingTracksWorkModel>> getWalkingTracksWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameWalk,
        columns: ['id','typeOfWork', 'startDate', 'expectedCompDate','walkingTracksCompStatus']
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
    List<WalkingTracksWorkModel> walkingTracksWork = [];
    for (int i = 0; i < maps.length; i++) {
      walkingTracksWork.add(WalkingTracksWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed WalkingTracksWorkModel objects:');
    }

    return walkingTracksWork;
  }

  Future<int>add(WalkingTracksWorkModel walkingTracksWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameWalk,walkingTracksWorkModel.toMap());
  }

  Future<int>update(WalkingTracksWorkModel walkingTracksWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameWalk,walkingTracksWorkModel.toMap(),
        where: 'id = ?', whereArgs: [walkingTracksWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameWalk,
        where: 'id = ?', whereArgs: [id]);
  }
}