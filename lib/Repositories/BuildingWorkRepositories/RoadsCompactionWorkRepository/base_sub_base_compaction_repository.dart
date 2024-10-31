import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/base_sub_base_compaction_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class BaseSubBaseCompactionRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<BaseSubBaseCompactionModel>> getSubBaseCompaction() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameBaseSubBaseCompaction,
        columns: ['id', 'block_no', 'road_no','working_hours','total_length','start_date','expected_comp_date','base_sub_base_comp_status','base_sub_base_compaction_date','time','posted','user_id']
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
    List<BaseSubBaseCompactionModel>  baseSubBaseCompaction= [];
    for (int i = 0; i < maps.length; i++) {
      baseSubBaseCompaction.add(BaseSubBaseCompactionModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed BaseSubBaseCompactionModel objects:');
    }
    return baseSubBaseCompaction;
  }
  Future<void> fetchAndSaveBaseSubBaseCompactionData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlBaseSubBaseCompaction}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      BaseSubBaseCompactionModel model = BaseSubBaseCompactionModel.fromMap(item);
      await dbClient.insert(tableNameBaseSubBaseCompaction, model.toMap());
    }
  }
  Future<List<BaseSubBaseCompactionModel>> getUnPostedBaseSubBase() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameBaseSubBaseCompaction,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<BaseSubBaseCompactionModel> baseSubBaseCompaction = maps.map((map) => BaseSubBaseCompactionModel.fromMap(map)).toList();
    return baseSubBaseCompaction;
  }
  Future<int>add(BaseSubBaseCompactionModel baseSubBaseCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameBaseSubBaseCompaction,baseSubBaseCompactionModel.toMap());
  }

  Future<int>update(BaseSubBaseCompactionModel baseSubBaseCompactionModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameBaseSubBaseCompaction,baseSubBaseCompactionModel.toMap(),
        where: 'id = ?', whereArgs: [baseSubBaseCompactionModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameBaseSubBaseCompaction,
        where: 'id = ?', whereArgs: [id]);
  }
}