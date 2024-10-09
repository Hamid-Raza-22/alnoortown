
import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/asphalt_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../../Globals/globals.dart';

class AsphaltWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<AsphaltWorkModel>> getAsphaltWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameAsphaltWork,
        columns: ['id', 'block_no', 'street_no', 'no_of_tons','back_filling_status','asphalt_work_date','time','posted','user_id']
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
    List<AsphaltWorkModel> asphaltWork = [];
    for (int i = 0; i < maps.length; i++) {
      asphaltWork.add(AsphaltWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed AsphaltWorkModel objects:');
    }

    return asphaltWork;
  }
  Future<void> fetchAndSaveAsphaltWorkData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlAsphaltWork}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      AsphaltWorkModel model = AsphaltWorkModel.fromMap(item);
      await dbClient.insert(tableNameAsphaltWork, model.toMap());
    }
  }
  Future<List<AsphaltWorkModel>> getUnPostedAsphaltWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameAsphaltWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<AsphaltWorkModel> asphaltWork = maps.map((map) => AsphaltWorkModel.fromMap(map)).toList();
    return asphaltWork;
  }
  Future<int>add(AsphaltWorkModel asphaltWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameAsphaltWork,asphaltWorkModel.toMap());
  }

  Future<int>update(AsphaltWorkModel asphaltWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameAsphaltWork,asphaltWorkModel.toMap(),
        where: 'id = ?', whereArgs: [asphaltWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameAsphaltWork,
        where: 'id = ?', whereArgs: [id]);
  }
}