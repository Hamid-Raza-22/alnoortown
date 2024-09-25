
import 'package:al_noor_town/Database/db_helper.dart';

import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_excavation_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../../Globals/globals.dart';

class PolesExcavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PolesExcavationModel>> getPolesExcavation() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePolesExcavation,
        columns: ['id', 'block_no', 'street_no', 'noOfExcavation','poles_excavation_date','time','posted']
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
    List<PolesExcavationModel> polesExcavation = [];
    for (int i = 0; i < maps.length; i++) {
      polesExcavation.add(PolesExcavationModel.fromMap(maps[i]));
    }

    if (kDebugMode) {
      print('Parsed PolesExcavationModel objects:');
    }

    return polesExcavation;
  }
  Future<void> fetchAndSavePolesExcavationData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlPolesExcavation);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      PolesExcavationModel model = PolesExcavationModel.fromMap(item);
      await dbClient.insert(tableNamePolesExcavation, model.toMap());
    }
  }
  Future<List<PolesExcavationModel>> getUnPostedPolesExcavation() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePolesExcavation,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<PolesExcavationModel> polesExcavation = maps.map((map) => PolesExcavationModel.fromMap(map)).toList();
    return polesExcavation;
  }
  Future<int>add(PolesExcavationModel polesExcavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePolesExcavation,polesExcavationModel.toMap());
  }

  Future<int>update(PolesExcavationModel polesExcavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePolesExcavation,polesExcavationModel.toMap(),
        where: 'id = ?', whereArgs: [polesExcavationModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePolesExcavation,
        where: 'id = ?', whereArgs: [id]);
  }
}