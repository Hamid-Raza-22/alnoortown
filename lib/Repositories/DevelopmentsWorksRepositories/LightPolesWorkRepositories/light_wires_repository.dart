

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';

import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/light_wires_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class LightWiresRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<LightWiresModel>> getLightWires() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameLightWires,
        columns: ['id', 'block_no', 'light_wire_work_status','street_no','total_length','light_wire_date','time','posted','user_id']
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
    List<LightWiresModel> lightWires = [];
    for (int i = 0; i < maps.length; i++) {
      lightWires.add(LightWiresModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed LightWiresModel objects:');
    }

    return lightWires;
  }
  Future<void> fetchAndSaveLightWiresWorkData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlLightWires}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      LightWiresModel model = LightWiresModel.fromMap(item);
      await dbClient.insert(tableNameLightWires, model.toMap());
    }
  }
  Future<List<LightWiresModel>> getUnPostedLightWires() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameLightWires,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<LightWiresModel> lightWires = maps.map((map) => LightWiresModel.fromMap(map)).toList();
    return lightWires;
  }

  Future<int>add(LightWiresModel lightWiresModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameLightWires,lightWiresModel.toMap());
  }

  Future<int>update(LightWiresModel lightWiresModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameLightWires,lightWiresModel.toMap(),
        where: 'id = ?', whereArgs: [lightWiresModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameLightWires,
        where: 'id = ?', whereArgs: [id]);
  }
}