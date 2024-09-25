

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mini_park_mud_filling_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class MiniParkMudFillingRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MiniParkMudFillingModel>> getMiniParkMudFilling() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMudFillingMiniPark,
        columns: ['id', 'startDate', 'expectedCompDate','mpMudFillingCompStatus','totalDumpers','mini_park_mud_filling_date','time','posted']
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
    List<MiniParkMudFillingModel>  miniParkMudFilling= [];
    for (int i = 0; i < maps.length; i++) {
      miniParkMudFilling.add(MiniParkMudFillingModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MiniParkMudFillingModel objects:');
    }

    return miniParkMudFilling;
  }
  Future<void> fetchAndSaveMiniParkMudFillingData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlMudFillingMiniPark);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      MiniParkMudFillingModel model = MiniParkMudFillingModel.fromMap(item);
      await dbClient.insert(tableNameMudFillingMiniPark, model.toMap());
    }
  }
  Future<List<MiniParkMudFillingModel>> getUnPostedMudFillingMp() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameMudFillingMiniPark,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<MiniParkMudFillingModel> miniParkMudFilling = maps.map((map) => MiniParkMudFillingModel.fromMap(map)).toList();
    return miniParkMudFilling;
  }
  Future<int>add(MiniParkMudFillingModel miniParkMudFillingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMudFillingMiniPark,miniParkMudFillingModel.toMap());
  }

  Future<int>update(MiniParkMudFillingModel miniParkMudFillingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMudFillingMiniPark,miniParkMudFillingModel.toMap(),
        where: 'id = ?', whereArgs: [miniParkMudFillingModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMudFillingMiniPark,
        where: 'id = ?', whereArgs: [id]);
  }
}