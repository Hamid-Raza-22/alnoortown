

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/plantation_work_model.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/sitting_area_work_model.dart';
import 'package:flutter/foundation.dart';

class SittingAreaWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<SittingAreaWorkModel>> getSittingAreaWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameSittingAreaWork,
        columns: ['id','typeOfWork', 'startDate', 'expectedCompDate','sittingAreaCompStatus','date','time','posted']
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
    List<SittingAreaWorkModel> sittingAreaWork = [];
    for (int i = 0; i < maps.length; i++) {
      sittingAreaWork.add(SittingAreaWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed SittingAreaWorkModel objects:');
    }

    return sittingAreaWork;
  }
  Future<List<SittingAreaWorkModel>> getUnPostedSittingArea() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameSittingAreaWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<SittingAreaWorkModel> sittingAreaWork = maps.map((map) => SittingAreaWorkModel.fromMap(map)).toList();
    return sittingAreaWork;
  }

  Future<int>add(SittingAreaWorkModel sittingAreaWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameSittingAreaWork,sittingAreaWorkModel.toMap());
  }

  Future<int>update(SittingAreaWorkModel sittingAreaWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameSittingAreaWork,sittingAreaWorkModel.toMap(),
        where: 'id = ?', whereArgs: [sittingAreaWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameSittingAreaWork,
        where: 'id = ?', whereArgs: [id]);
  }
}