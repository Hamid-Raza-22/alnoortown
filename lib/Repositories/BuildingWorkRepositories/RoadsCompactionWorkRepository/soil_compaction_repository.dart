

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/soil_compaction_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class SoilCompactionRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<SoilCompactionModel>> getSoilCompaction() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameSoilCompaction,
        columns: ['id', 'block_no', 'road_no','total_length','start_date','expected_comp_date','soil_comp_status','soil_compaction_date','time','posted','user_id']
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
    List<SoilCompactionModel>  soilCompaction= [];
    for (int i = 0; i < maps.length; i++) {
      soilCompaction.add(SoilCompactionModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed SoilCompactionModel objects:');
    }

    return soilCompaction;
  }
  Future<void> fetchAndSaveSoilCompactionData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlSoilCompaction);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      SoilCompactionModel model = SoilCompactionModel.fromMap(item);
      await dbClient.insert(tableNameSoilCompaction, model.toMap());
    }
  }
  Future<List<SoilCompactionModel>> getUnPostedSoilCompaction() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameSoilCompaction,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<SoilCompactionModel> soilCompaction = maps.map((map) => SoilCompactionModel.fromMap(map)).toList();
    return soilCompaction;
  }
  Future<int>add(SoilCompactionModel soilCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameSoilCompaction,soilCompactionModel.toMap());
  }

  Future<int>update(SoilCompactionModel soilCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameSoilCompaction,soilCompactionModel.toMap(),
        where: 'id = ?', whereArgs: [soilCompactionModel.id]);
  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameSoilCompaction,
        where: 'id = ?', whereArgs: [id]);
  }
}