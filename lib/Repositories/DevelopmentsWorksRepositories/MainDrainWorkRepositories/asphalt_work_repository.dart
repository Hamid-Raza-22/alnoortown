
import 'package:al_noor_town/Database/db_helper.dart';

import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/asphalt_work_model.dart';
import 'package:flutter/foundation.dart';

import '../../../Globals/globals.dart';

class AsphaltWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<AsphaltWorkModel>> getAsphaltWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameAsphaltWork,
        columns: ['id', 'blockNo', 'streetNo', 'numOfTons','backFillingStatus','date','time','posted']
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
    List<AsphaltWorkModel> asphaltWork = [];
    for (int i = 0; i < maps.length; i++) {
      asphaltWork.add(AsphaltWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed AsphaltWorkModel objects:');
    }

    return asphaltWork;
  }
  Future<List<AsphaltWorkModel>> getUnPostedAsphaltWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameAsphaltWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<AsphaltWorkModel> asphaltWork = maps.map((map) => AsphaltWorkModel.fromMap(map)).toList();
    return asphaltWork;
  }
  Future<int>add(AsphaltWorkModel asphaltWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameAsphaltWork,asphaltWorkModel.toMap());
  }

  Future<int>update(AsphaltWorkModel asphaltWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameAsphaltWork,asphaltWorkModel.toMap(),
        where: 'id = ?', whereArgs: [asphaltWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameAsphaltWork,
        where: 'id = ?', whereArgs: [id]);
  }
}