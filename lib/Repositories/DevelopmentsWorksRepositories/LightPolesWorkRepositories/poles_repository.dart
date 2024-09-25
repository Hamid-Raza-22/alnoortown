
import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
class PolesRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PolesModel>> getPoles() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePoles,
        columns: ['id', 'block_no', 'street_no','no_of_poles','poles_date','time','posted']
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
    List<PolesModel> poles = [];
    for (int i = 0; i < maps.length; i++) {
      poles.add(PolesModel.fromMap(maps[i]));
    }

    if (kDebugMode) {
      print('Parsed PolesModel objects:');
    }
    return poles;
  }
  Future<void> fetchAndSavePolesWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlPoles);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      PolesModel model = PolesModel.fromMap(item);
      await dbClient.insert(tableNamePoles, model.toMap());
    }
  }
  Future<List<PolesModel>> getUnPostedPoles() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePoles,
      where: 'posted = ?',
      whereArgs: [0],
    );

    List<PolesModel> poles = maps.map((map) => PolesModel.fromMap(map)).toList();
    return poles;
  }
  Future<int>add(PolesModel polesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePoles,polesModel.toMap());
  }

  Future<int>update(PolesModel polesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePoles,polesModel.toMap(),
        where: 'id = ?', whereArgs: [polesModel.id]);
  }
  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePoles,
        where: 'id = ?', whereArgs: [id]);
  }
}