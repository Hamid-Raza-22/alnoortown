import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/main_drain_exavation_model.dart';
import 'package:flutter/foundation.dart';

class MainDrainExavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MainDrainExavationModel>> getMainDrainExavation() async {
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
    List<MainDrainExavationModel> mainDrainExavation = [];
    for (int i = 0; i < maps.length; i++) {
      mainDrainExavation.add(MainDrainExavationModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed MainDrainExavationModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return mainDrainExavation;
  }




  Future<int>add(MainDrainExavationModel mainDrainExavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameDrain,mainDrainExavationModel.toMap());
  }

  Future<int>update(MainDrainExavationModel mainDrainExavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameDrain,mainDrainExavationModel.toMap(),
        where: 'id = ?', whereArgs: [mainDrainExavationModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameDrain,
        where: 'id = ?', whereArgs: [id]);
  }
}