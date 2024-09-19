

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/iron_works_model.dart';
import 'package:flutter/foundation.dart';

class IronWorksRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<IronWorksModel>> getIronWorks() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameIronWork,
        columns: ['id', 'blockNo', 'streetNo', 'completedLength','date','time','posted']
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
    List<IronWorksModel> ironWorks = [];
    for (int i = 0; i < maps.length; i++) {
      ironWorks.add(IronWorksModel.fromMap(maps[i]));
    }

    if (kDebugMode) {
      print('Parsed IronWorksModel objects:');
    }
    return ironWorks;
  }
  Future<List<IronWorksModel>> getUnPostedIronWorks() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameIronWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<IronWorksModel> ironWorks = maps.map((map) => IronWorksModel.fromMap(map)).toList();
    return ironWorks;
  }
  Future<int>add(IronWorksModel ironWorksModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameIronWork,ironWorksModel.toMap());
  }

  Future<int>update(IronWorksModel ironWorksModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameIronWork,ironWorksModel.toMap(),
        where: 'id = ?', whereArgs: [ironWorksModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameIronWork,
        where: 'id = ?', whereArgs: [id]);
  }
}