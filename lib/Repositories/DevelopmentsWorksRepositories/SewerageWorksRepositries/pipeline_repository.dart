

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/pipeline_model.dart';
import 'package:flutter/foundation.dart';

class PipelineRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PipelineModel>> getPipeline() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePipeline,
        columns: ['id', 'blockNo', 'streetNo', 'length','date']
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
    List<PipelineModel> pipeline = [];
    for (int i = 0; i < maps.length; i++) {
      pipeline.add(PipelineModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed PipelineModel objects:');
    }
    // for (var item in machine) {
    //   if (kDebugMode) {
    //     print(item);
    //   }
    // }

    return pipeline;
  }




  Future<int>add(PipelineModel pipelineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePipeline,pipelineModel.toMap());
  }

  Future<int>update(PipelineModel pipelineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePipeline,pipelineModel.toMap(),
        where: 'id = ?', whereArgs: [pipelineModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePipeline,
        where: 'id = ?', whereArgs: [id]);
  }
}