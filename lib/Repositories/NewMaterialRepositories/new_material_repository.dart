
import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/NewMaterialModels/new_material_model.dart';
import 'package:flutter/foundation.dart';
class NewMaterialRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<NewMaterialModel>> getNewMaterial() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameNewMaterials,
        columns: ['id', 'sand','soil', 'base', 'subBase','waterBound','otherMaterial','otherMaterialValue','date','time','posted']
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
    List<NewMaterialModel> newMaterial = [];
    for (int i = 0; i < maps.length; i++) {
      newMaterial.add(NewMaterialModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed NewMaterialModel objects:');
    }

    return newMaterial;
  }
  Future<List<NewMaterialModel>> getUnPostedNewMaterial() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameNewMaterials,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<NewMaterialModel> newMaterial = maps.map((map) => NewMaterialModel.fromMap(map)).toList();
    return newMaterial;
  }
  Future<int>add(NewMaterialModel newMaterialModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameNewMaterials,newMaterialModel.toMap());
  }

  Future<int>update(NewMaterialModel newMaterialModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameNewMaterials,newMaterialModel.toMap(),
        where: 'id = ?', whereArgs: [newMaterialModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameNewMaterials,
        where: 'id = ?', whereArgs: [id]);
  }
}