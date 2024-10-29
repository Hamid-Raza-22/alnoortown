import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import '../../../../Models/BuildingWorkModels/BoundarywallModel/PlanksModel/planks_fixing_model.dart';

class PlanksFixingRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PlanksFixingModel>> getPlanksFixing() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePlanksFixing,
        columns: ['id','block', 'no_of_planks','total_length','planks_fixing_date','time','posted','user_id']
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
    List<PlanksFixingModel> planksFixing = [];
    for (int i = 0; i < maps.length; i++) {
      planksFixing.add(PlanksFixingModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed PlanksFixingModel objects:');
    }

    return planksFixing;
  }
  Future<void> fetchAndSavePlanksFixingData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlPlanksFixing}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      PlanksFixingModel model = PlanksFixingModel.fromMap(item);
      await dbClient.insert(tableNamePlanksFixing, model.toMap());
    }
  }

  Future<List<PlanksFixingModel>> getUnPostedPlanksFixing() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePlanksFixing,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<PlanksFixingModel> planksFixing = maps.map((map) => PlanksFixingModel.fromMap(map)).toList();
    return planksFixing;
  }
  Future<int>add(PlanksFixingModel planksFixingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePlanksFixing,planksFixingModel.toMap());
  }

  Future<int>update(PlanksFixingModel planksFixingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePlanksFixing,planksFixingModel.toMap(),
        where: 'id = ?', whereArgs: [planksFixingModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePlanksFixing,
        where: 'id = ?', whereArgs: [id]);
  }
}