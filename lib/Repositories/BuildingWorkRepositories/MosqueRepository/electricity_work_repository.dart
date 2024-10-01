import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/electricity_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class ElectricityWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ElectricityWorkModel>> getElectricityWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameElectricityWorkMosque,
        columns: ['id', 'block_no', 'electricity_work_status','electricity_work_date','time','posted','user_id']
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
    List<ElectricityWorkModel> electricityWork = [];
    for (int i = 0; i < maps.length; i++) {
      electricityWork.add(ElectricityWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed ElectricityWorkModel objects:');
    }

    return electricityWork;
  }
  Future<void> fetchAndSaveElectricityWorkData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlElectricityWorkMosque);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      ElectricityWorkModel model = ElectricityWorkModel.fromMap(item);
      await dbClient.insert(tableNameElectricityWorkMosque, model.toMap());
    }
  }
  Future<List<ElectricityWorkModel>> getUnPostedElectricityWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameElectricityWorkMosque,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<ElectricityWorkModel> electricityWork = maps.map((map) => ElectricityWorkModel.fromMap(map)).toList();
    return electricityWork;
  }
  Future<int>add(ElectricityWorkModel electricityWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameElectricityWorkMosque,electricityWorkModel.toMap());
  }

  Future<int>update(ElectricityWorkModel electricityWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameElectricityWorkMosque,electricityWorkModel.toMap(),
        where: 'id = ?', whereArgs: [electricityWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameElectricityWorkMosque,
        where: 'id = ?', whereArgs: [id]);
  }
}