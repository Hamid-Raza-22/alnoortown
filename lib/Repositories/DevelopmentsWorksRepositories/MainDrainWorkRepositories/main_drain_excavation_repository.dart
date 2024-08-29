import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/main_drain_excavation_model.dart';
import 'package:flutter/foundation.dart';

class MainDrainExcavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MainDrainExcavationModel>> getMainDrainExcavation() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameDrain,
        columns: ['id', 'blockNo', 'streetNo', 'completedLength','date']
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
    List<MainDrainExcavationModel> mainDrainExcavation = [];
    for (int i = 0; i < maps.length; i++) {
      mainDrainExcavation.add(MainDrainExcavationModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed MainDrainExcavationModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return mainDrainExcavation;
  }




  Future<int>add(MainDrainExcavationModel mainDrainExcavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameDrain,mainDrainExcavationModel.toMap());
  }

  Future<int>update(MainDrainExcavationModel mainDrainExcavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameDrain,mainDrainExcavationModel.toMap(),
        where: 'id = ?', whereArgs: [mainDrainExcavationModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameDrain,
        where: 'id = ?', whereArgs: [id]);
  }
}