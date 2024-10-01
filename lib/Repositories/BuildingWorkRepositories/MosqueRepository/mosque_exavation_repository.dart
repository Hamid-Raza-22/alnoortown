import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/mosque_excavation_work.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../../Globals/globals.dart';
class MosqueExcavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MosqueExcavationWorkModel>> getMosqueExcavation() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMosqueExcavationWork,
        columns: ['id', 'block_no', 'completion_status', 'mosque_excavation_work_date', 'time','posted','user_id']
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

    // Convert the raw data into a list
    List<MosqueExcavationWorkModel> mosqueExavationWork = [];
    for (int i = 0; i < maps.length; i++) {
      mosqueExavationWork.add(MosqueExcavationWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed MosqueExcavationWorkModel objects:');
    }
    return mosqueExavationWork;
  }
  Future<void> fetchAndSaveExcavationWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlMosqueExcavationWork);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      MosqueExcavationWorkModel model = MosqueExcavationWorkModel.fromMap(item);
      await dbClient.insert(tableNameMosqueExcavationWork, model.toMap());
    }
  }
  Future<List<MosqueExcavationWorkModel>> getUnPostedMosqueExcavation() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameMosqueExcavationWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<MosqueExcavationWorkModel> mosqueExavationWork = maps.map((map) => MosqueExcavationWorkModel.fromMap(map)).toList();
    return mosqueExavationWork;
  }
  Future<int>add(MosqueExcavationWorkModel mosqueExcavationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMosqueExcavationWork,mosqueExcavationWorkModel.toMap());
  }

  Future<int>update(MosqueExcavationWorkModel mosqueExcavationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMosqueExcavationWork,mosqueExcavationWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mosqueExcavationWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMosqueExcavationWork,
        where: 'id = ?', whereArgs: [id]);
  }
}