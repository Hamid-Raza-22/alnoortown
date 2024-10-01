import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/ceiling_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class CeilingWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<CeilingWorkModel>> getCeilingWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameCeilingWorkMosque,
        columns: ['id', 'block_no', 'ceiling_work_status','ceiling_work_date','time','posted','user_id']
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
    List<CeilingWorkModel> ceilingWork = [];
    for (int i = 0; i < maps.length; i++) {
      ceilingWork.add(CeilingWorkModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed CeilingWorkModel objects:');
    }

    return ceilingWork;
  }
  Future<void> fetchAndSaveCeilingWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlCeilingWorkMosque);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      CeilingWorkModel model = CeilingWorkModel.fromMap(item);
      await dbClient.insert(tableNameCeilingWorkMosque, model.toMap());
    }
  }
  Future<List<CeilingWorkModel>> getUnPostedCeilingWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameCeilingWorkMosque,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<CeilingWorkModel> ceilingWork = maps.map((map) => CeilingWorkModel.fromMap(map)).toList();
    return ceilingWork;
  }
  Future<int>add(CeilingWorkModel ceilingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameCeilingWorkMosque,ceilingWorkModel.toMap());
  }

  Future<int>update(CeilingWorkModel ceilingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameCeilingWorkMosque,ceilingWorkModel.toMap(),
        where: 'id = ?', whereArgs: [ceilingWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameCeilingWorkMosque,
        where: 'id = ?', whereArgs: [id]);
  }
}