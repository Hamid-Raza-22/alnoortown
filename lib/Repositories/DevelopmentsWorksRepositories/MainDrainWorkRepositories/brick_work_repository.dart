
import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/brick_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
class BrickWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<BrickWorkModel>> getBrickWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameBrickWork,
        columns: ['id', 'block_no', 'street_no', 'completed_length','brick_work_date','time','posted']
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
    List<BrickWorkModel> brick_work = [];
    for (int i = 0; i < maps.length; i++) {
      brick_work.add(BrickWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed BrickWorkModel objects:');
    }
    return brick_work;
  }
  Future<void> fetchAndSaveBrickWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlBrickWork);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      BrickWorkModel model = BrickWorkModel.fromMap(item);
      await dbClient.insert(tableNameBrickWork, model.toMap());
    }
  }
  Future<List<BrickWorkModel>> getUnPostedBrickWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameBrickWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<BrickWorkModel> brickWork = maps.map((map) => BrickWorkModel.fromMap(map)).toList();
    return brickWork;
  }
  Future<int>add(BrickWorkModel brickWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameBrickWork,brickWorkModel.toMap());
  }

  Future<int>update(BrickWorkModel brickWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameBrickWork,brickWorkModel.toMap(),
        where: 'id = ?', whereArgs: [brickWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameBrickWork,
        where: 'id = ?', whereArgs: [id]);
  }
}