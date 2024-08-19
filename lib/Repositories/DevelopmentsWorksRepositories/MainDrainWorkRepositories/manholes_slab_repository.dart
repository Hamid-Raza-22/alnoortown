

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/manholes_slab_model.dart';
import 'package:flutter/foundation.dart';



class ManholesSlabRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ManholesSlabModel>> getManHolesSlab() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameSlab,
        columns: ['id', 'blockNo', 'streetNo', 'numOfCompSlab','date']
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
    List<ManholesSlabModel> manholesSlab = [];
    for (int i = 0; i < maps.length; i++) {
      manholesSlab.add(ManholesSlabModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed ManholesSlabModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return manholesSlab;
  }




  Future<int>add(ManholesSlabModel manHolesSlabModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameSlab,manHolesSlabModel.toMap());
  }

  Future<int>update(ManholesSlabModel manHolesSlabModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameSlab,manHolesSlabModel.toMap(),
        where: 'id = ?', whereArgs: [manHolesSlabModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameSlab,
        where: 'id = ?', whereArgs: [id]);
  }
}