import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/paint_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
class PaintWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PaintWorkModel>> getPaintWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePaintWorkMosque,
        columns: ['id', 'block_no', 'paint_work_status','paint_work_date','time','posted','user_id']
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
    List<PaintWorkModel> paintWork = [];
    for (int i = 0; i < maps.length; i++) {
     paintWork.add(PaintWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed PaintWorkModel objects:');
    }

    return paintWork;
  }
  Future<void> fetchAndSavePaintWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlPaintWorkMosque);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      PaintWorkModel model = PaintWorkModel.fromMap(item);
      await dbClient.insert(tableNamePaintWorkMosque, model.toMap());
    }
  }
  Future<List<PaintWorkModel>> getUnPostedPaintWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePaintWorkMosque,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<PaintWorkModel> paintWork = maps.map((map) => PaintWorkModel.fromMap(map)).toList();
    return paintWork;
  }
  Future<int>add(PaintWorkModel paintWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePaintWorkMosque,paintWorkModel.toMap());
  }

  Future<int>update(PaintWorkModel paintWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePaintWorkMosque,paintWorkModel.toMap(),
        where: 'id = ?', whereArgs: [paintWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePaintWorkMosque,
        where: 'id = ?', whereArgs: [id]);
  }
}