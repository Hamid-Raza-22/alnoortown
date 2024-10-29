

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';

import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';


import '../../../../Models/BuildingWorkModels/BoundarywallModel/PillarsModel/pillars_removal_model.dart';

class PillarsRemovalRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PillarsRemovalModel>> getPillarsRemoval() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePillarsRemoval,
        columns: ['id', 'block','no_of_pillars','total_length','pillars_removal_date','time','posted','user_id']
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
    List<PillarsRemovalModel> pillarsRemoval = [];
    for (int i = 0; i < maps.length; i++) {
      pillarsRemoval.add(PillarsRemovalModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed PillarsRemovalModel objects:');
    }

    return pillarsRemoval;
  }
  Future<void> fetchAndSavePillarsRemovalData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlPillarsRemoval}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      PillarsRemovalModel model = PillarsRemovalModel.fromMap(item);
      await dbClient.insert(tableNamePillarsRemoval, model.toMap());
    }
  }

  Future<List<PillarsRemovalModel>> getUnPostedPillarsRemoval() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePillarsRemoval,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<PillarsRemovalModel> pillarsRemoval = maps.map((map) => PillarsRemovalModel.fromMap(map)).toList();
    return pillarsRemoval;
  }
  Future<int>add(PillarsRemovalModel pillarsRemovalModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePillarsRemoval,pillarsRemovalModel.toMap());
  }

  Future<int>update(PillarsRemovalModel pillarsRemovalModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePillarsRemoval,pillarsRemovalModel.toMap(),
        where: 'id = ?', whereArgs: [pillarsRemovalModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePillarsRemoval,
        where: 'id = ?', whereArgs: [id]);
  }
}