

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/boundary_grill_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../../../Models/BuildingWorkModels/BoundarywallModel/PillarsModel/pillars_fixing_model.dart';

class PillarsFixingRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PillarsFixingModel>> getPillarsFixing() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePillarsFixing,
        columns: ['id','block', 'no_of_pillars','total_length','pillars_fixing_date','time','posted','user_id']
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
    List<PillarsFixingModel> pillarsFixing = [];
    for (int i = 0; i < maps.length; i++) {
      pillarsFixing.add(PillarsFixingModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed PillarsFixingModel objects:');
    }

    return pillarsFixing;
  }
  Future<void> fetchAndSavePillarsFixingData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlPillarsFixing}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      PillarsFixingModel model = PillarsFixingModel.fromMap(item);
      await dbClient.insert(tableNamePillarsFixing, model.toMap());
    }
  }

  Future<List<PillarsFixingModel>> getUnPostedPillarsFixing() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePillarsFixing,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<PillarsFixingModel> pillarsFixing = maps.map((map) => PillarsFixingModel.fromMap(map)).toList();
    return pillarsFixing;
  }
  Future<int>add(PillarsFixingModel pillarsFixingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePillarsFixing,pillarsFixingModel.toMap());
  }

  Future<int>update(PillarsFixingModel pillarsFixingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePillarsFixing,pillarsFixingModel.toMap(),
        where: 'id = ?', whereArgs: [pillarsFixingModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePillarsFixing,
        where: 'id = ?', whereArgs: [id]);
  }
}