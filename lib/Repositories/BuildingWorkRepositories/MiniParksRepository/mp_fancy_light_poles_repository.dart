import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mp_fancy_light_poles_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class MpFancyLightPolesRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MpFancyLightPolesModel>> getMpFancyLightPoles() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameFancyLightPolesMiniPark,
        columns: ['id', 'start_date', 'expected_comp_date','mini_park_fancy_light_comp_status','mini_park_fancy_light_poles_date','time','posted','user_id']
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
    List<MpFancyLightPolesModel>  mpFancyLightPoles= [];
    for (int i = 0; i < maps.length; i++) {
      mpFancyLightPoles.add(MpFancyLightPolesModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed MpFancyLightPolesModel objects:');
    }

    return mpFancyLightPoles;
  }
  Future<void> fetchAndSaveMiniParkFancyWorkData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlFancyLightPolesMiniPark}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      MpFancyLightPolesModel model = MpFancyLightPolesModel.fromMap(item);
      await dbClient.insert(tableNameFancyLightPolesMiniPark, model.toMap());
    }
  }
  Future<List<MpFancyLightPolesModel>> getUnPostedFancyLightPolesMp() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameFancyLightPolesMiniPark,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<MpFancyLightPolesModel> mpFancyLightPoles = maps.map((map) => MpFancyLightPolesModel.fromMap(map)).toList();
    return mpFancyLightPoles;
  }
  Future<int>add(MpFancyLightPolesModel mpFancyLightPolesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameFancyLightPolesMiniPark,mpFancyLightPolesModel.toMap());
  }

  Future<int>update(MpFancyLightPolesModel mpFancyLightPolesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameFancyLightPolesMiniPark,mpFancyLightPolesModel.toMap(),
        where: 'id = ?', whereArgs: [mpFancyLightPolesModel.id]);
  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameFancyLightPolesMiniPark,
        where: 'id = ?', whereArgs: [id]);
  }
}