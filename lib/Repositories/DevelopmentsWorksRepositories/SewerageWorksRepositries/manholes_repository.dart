

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/manholes_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class ManholesRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ManholesModel>> getManholes() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameManholes,
        columns: ['id', 'block_no', 'street_no', 'no_of_manholes','manholes_date','time','posted','user_id']
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

    // Convert the raw data into a list of MachineModel objects
    List<ManholesModel> manholes = [];
    for (int i = 0; i < maps.length; i++) {
      manholes.add(ManholesModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed ManholesModel objects:');
    }
    return manholes;
  }
  Future<void> fetchAndSaveManholesData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlManholes}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      ManholesModel model = ManholesModel.fromMap(item);
      await dbClient.insert(tableNameManholes, model.toMap());
    }
  }
  Future<List<ManholesModel>> getUnPostedManHolesSewerageWorks() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameManholes,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<ManholesModel> manholes = maps.map((map) => ManholesModel.fromMap(map)).toList();
    return manholes;
  }
  Future<int>add(ManholesModel manholesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameManholes,manholesModel.toMap());
  }

  Future<int>update(ManholesModel manholesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameManholes,manholesModel.toMap(),
        where: 'id = ?', whereArgs: [manholesModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameManholes,
        where: 'id = ?', whereArgs: [id]);
  }
}