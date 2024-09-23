
import 'package:al_noor_town/Database/db_helper.dart';

import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/excavation_model.dart';
import 'package:flutter/foundation.dart';

import '../../../Globals/globals.dart';

class ExcavationRepository{
  DBHelper dbHelper = DBHelper();

  Future<List<ExcavationModel>> getExcavation() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameExcavation,
        columns: ['id', 'block_no', 'street_no', 'length','date','time','posted']
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
    List<ExcavationModel> excavation = [];
    for (int i = 0; i < maps.length; i++) {
      excavation.add(ExcavationModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed ExcavationModel objects:');
    }

    return excavation;
  }
  Future<List<ExcavationModel>> getUnPostedExcavationSewerageWorks() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameExcavation,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<ExcavationModel> excavation = maps.map((map) => ExcavationModel.fromMap(map)).toList();
    return excavation;
  }
  Future<int>add(ExcavationModel excavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameExcavation,excavationModel.toMap());
  }

  Future<int>update(ExcavationModel excavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameExcavation,excavationModel.toMap(),
        where: 'id = ?', whereArgs: [excavationModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameExcavation,
        where: 'id = ?', whereArgs: [id]);
  }
}