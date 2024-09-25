

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/pipeline_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class PipelineRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PipelineModel>> getPipeline() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNamePipeLaying,
        columns: ['id', 'block_no', 'street_no', 'length','pipe_laying_date','time','posted']
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
    return pipeline;
  }
  Future<void> fetchAndSavePipelineData() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlPipeLaying);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      PipelineModel model = PipelineModel.fromMap(item);
      await dbClient.insert(tableNameWaterTanker, model.toMap());
    }
  }
  Future<List<PipelineModel>> getUnPostedPipeLine() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNamePipeLaying,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<PipelineModel> pipeline = maps.map((map) => PipelineModel.fromMap(map)).toList();
    return pipeline;
  }
  Future<int>add(PipelineModel pipelineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePipeLaying,pipelineModel.toMap());
  }

  Future<int>update(PipelineModel pipelineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePipeLaying,pipelineModel.toMap(),
        where: 'id = ?', whereArgs: [pipelineModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePipeLaying,
        where: 'id = ?', whereArgs: [id]);
  }
}