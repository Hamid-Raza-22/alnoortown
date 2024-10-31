
import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../../Globals/globals.dart';
import '../../../Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_foundation_model.dart';

class PolesFoundationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PolesFoundationModel>> getPolesFoundation() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePolesFoundation,
        columns: ['id', 'block_no', 'street_no', 'no_of_foundation','poles_foundation_date','time','posted','user_id']
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
    List<PolesFoundationModel> polesFoundation = [];
    for (int i = 0; i < maps.length; i++) {
      polesFoundation.add(PolesFoundationModel.fromMap(maps[i]));
    }

    if (kDebugMode) {
      print('Parsed PolesFoundationModel objects:');
    }

    return polesFoundation;
  }
  Future<void> fetchAndSavePolesFoundationData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlPolesFoundation}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      PolesFoundationModel model = PolesFoundationModel.fromMap(item);
      await dbClient.insert(tableNamePolesFoundation, model.toMap());
    }
  }
  Future<List<PolesFoundationModel>> getUnPostedPolesFoundation() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePolesFoundation,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<PolesFoundationModel> polesFoundation = maps.map((map) => PolesFoundationModel.fromMap(map)).toList();
    return polesFoundation;
  }
  Future<int>add(PolesFoundationModel polesFoundationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePolesFoundation,polesFoundationModel.toMap());
  }

  Future<int>update(PolesFoundationModel polesFoundationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePolesFoundation,polesFoundationModel.toMap(),
        where: 'id = ?', whereArgs: [polesFoundationModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePolesFoundation,
        where: 'id = ?', whereArgs: [id]);
  }
}