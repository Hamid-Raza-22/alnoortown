

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
        tableNameWalkingTracksWork,
        columns: ['id','typeOfWork', 'startDate', 'expectedCompDate','walkingTracksCompStatus','date','time','posted']
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
  Future<List<WalkingTracksWorkModel>> getUnPostedWalkingTrack() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameWalkingTracksWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<WalkingTracksWorkModel> walkingTracksWork = maps.map((map) => WalkingTracksWorkModel.fromMap(map)).toList();
    return walkingTracksWork;
  }
  Future<int>add(WalkingTracksWorkModel walkingTracksWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameWalkingTracksWork,walkingTracksWorkModel.toMap());
  }

  Future<int>update(WalkingTracksWorkModel walkingTracksWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameWalkingTracksWork,walkingTracksWorkModel.toMap(),
        where: 'id = ?', whereArgs: [walkingTracksWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameWalkingTracksWork,
        where: 'id = ?', whereArgs: [id]);
  }
}