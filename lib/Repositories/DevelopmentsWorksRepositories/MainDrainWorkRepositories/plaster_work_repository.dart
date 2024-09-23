
import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/plaster_work_model.dart';
import 'package:flutter/foundation.dart';

class PlasterWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PlasterWorkModel>> getPlasterWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePlasterWork,
        columns: ['id', 'block_no', 'street_no', 'completedLength','date','time','posted']
    );

    if (kDebugMode) {
      print('Raw data from database:');
    }
    for (var map in maps) {
      if (kDebugMode) {
        print(map);
      }
    }
    List<PlasterWorkModel> plasterWork = [];
    for (int i = 0; i < maps.length; i++) {
      plasterWork.add(PlasterWorkModel.fromMap(maps[i]));
    }
    if (kDebugMode) {
      print('Parsed PlasterWorkModel objects:');
    }
    return plasterWork;
  }
  Future<List<PlasterWorkModel>> getUnPostedPlasterWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePlasterWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<PlasterWorkModel> plasterWork = maps.map((map) => PlasterWorkModel.fromMap(map)).toList();
    return plasterWork;
  }
  Future<int>add(PlasterWorkModel plasterWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePlasterWork,plasterWorkModel.toMap());
  }

  Future<int>update(PlasterWorkModel plasterWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePlasterWork,plasterWorkModel.toMap(),
        where: 'id = ?', whereArgs: [plasterWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePlasterWork,
        where: 'id = ?', whereArgs: [id]);
  }
}