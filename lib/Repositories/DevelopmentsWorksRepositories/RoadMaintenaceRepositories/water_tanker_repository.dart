
import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/water_tanker_model.dart';
import 'package:flutter/foundation.dart';

class WaterTankerRepository{

  DBHelper dbHelper = DBHelper();
  // Fetch all unposted machines (posted = 0)
  Future<List<WaterTankerModel>> getUnPostedWaterTanker() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameWaterTanker,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<WaterTankerModel> waterTankerModel = maps.map((map) => WaterTankerModel.fromMap(map)).toList();
    return waterTankerModel;
  }
  Future<List<WaterTankerModel>> getTanker() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameWaterTanker,
        columns: ['id', 'blockNo', 'streetNo', 'tankerNo','date','time','posted']
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
    List<WaterTankerModel> waterTanker = [];
    for (int i = 0; i < maps.length; i++) {
      waterTanker.add(WaterTankerModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed WaterTankerModel objects:');
    }

    return waterTanker;
  }

  Future<int>add(WaterTankerModel waterTankerModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameWaterTanker,waterTankerModel.toMap());
  }

  Future<int>update(WaterTankerModel waterTankerModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameWaterTanker,waterTankerModel.toMap(),
        where: 'id = ?', whereArgs: [waterTankerModel.id]);

  }

  Future<int>delete(int? id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameWaterTanker,
        where: 'id = ?', whereArgs: [id]);
  }
}