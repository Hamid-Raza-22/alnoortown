import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/sand_compaction_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class SandCompactionRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<SandCompactionModel>> getSandCompaction() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameSandCompaction,
        columns: ['id', 'block_no', 'road_no','total_length','start_date','expected_comp_date','sand_comp_status','sand_compaction_date','time','posted','user_id']
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
    List<SandCompactionModel>  sandCompaction= [];
    for (int i = 0; i < maps.length; i++) {
      sandCompaction.add(SandCompactionModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed SandCompactionModel objects:');
    }

    return sandCompaction;
  }
  Future<void> fetchAndSaveSandCompactionData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlSandCompaction);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      SandCompactionModel model = SandCompactionModel.fromMap(item);
      await dbClient.insert(tableNameSandCompaction, model.toMap());
    }
  }
  Future<List<SandCompactionModel>> getUnPostedSandCompaction() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameSandCompaction,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<SandCompactionModel> sandCompaction = maps.map((map) => SandCompactionModel.fromMap(map)).toList();
    return sandCompaction;
  }
  Future<int>add(SandCompactionModel sandCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameSandCompaction,sandCompactionModel.toMap());
  }

  Future<int>update(SandCompactionModel sandCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameSandCompaction,sandCompactionModel.toMap(),
        where: 'id = ?', whereArgs: [sandCompactionModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameSandCompaction,
        where: 'id = ?', whereArgs: [id]);
  }
}