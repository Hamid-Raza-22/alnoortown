

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';

import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';



import '../../../../Models/BuildingWorkModels/BoundarywallModel/PlanksModel/planks_removal_model.dart';

class PlanksRemovalRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PlanksRemovalModel>> getPlanksRemoval() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePlanksRemoval,
        columns: ['id', 'block','no_of_planks','total_length','planks_removal_date','time','posted','user_id']
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
    List<PlanksRemovalModel> planksRemoval = [];
    for (int i = 0; i < maps.length; i++) {
      planksRemoval.add(PlanksRemovalModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed PlanksRemovalModel objects:');
    }

    return planksRemoval;
  }
  Future<void> fetchAndSavePlanksRemovalData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlPlanksRemoval}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      PlanksRemovalModel model = PlanksRemovalModel.fromMap(item);
      await dbClient.insert(tableNamePlanksRemoval, model.toMap());
    }
  }

  Future<List<PlanksRemovalModel>> getUnPostedPlanksRemoval() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePlanksRemoval,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<PlanksRemovalModel> planksRemoval = maps.map((map) => PlanksRemovalModel.fromMap(map)).toList();
    return planksRemoval;
  }
  Future<int>add(PlanksRemovalModel planksRemovalModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePlanksRemoval,planksRemovalModel.toMap());
  }

  Future<int>update(PlanksRemovalModel planksRemovalModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePlanksRemoval,planksRemovalModel.toMap(),
        where: 'id = ?', whereArgs: [planksRemovalModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePlanksRemoval,
        where: 'id = ?', whereArgs: [id]);
  }
}