

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/filing_model.dart';
import 'package:flutter/foundation.dart';




class FillingRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<FilingModel>> getFiling() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameFiling,
        columns: ['id', 'blockNo', 'streetNo', 'status','date']
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
    List<FilingModel> filing = [];
    for (int i = 0; i < maps.length; i++) {
      filing.add(FilingModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed ExavationModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return filing;
  }


  Future<int>add(FilingModel filingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameFiling,filingModel.toMap());
  }

  Future<int>update(FilingModel filingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameFiling,filingModel.toMap(),
        where: 'id = ?', whereArgs: [filingModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameFiling,
        where: 'id = ?', whereArgs: [id]);
  }
}