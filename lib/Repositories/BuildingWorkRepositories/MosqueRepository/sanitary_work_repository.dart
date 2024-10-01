import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/sanitary_work_model.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../../Services/ApiServices/api_service.dart';

class SanitaryWorkRepository{
  DBHelper dbHelper = DBHelper();

  Future<List<SanitaryWorkModel>> getSanitaryWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameSanitaryWorkMosque,
        columns: ['id', 'block_no', 'sanitary_work_status','sanitary_work_date','time','posted','user_id']
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

    // Convert the raw data
    List<SanitaryWorkModel> sanitaryWork = [];
    for (int i = 0; i < maps.length; i++) {
      sanitaryWork.add(SanitaryWorkModel.fromMap(maps[i]));
    }

    // Print the list
    if (kDebugMode) {
      print('Parsed SanitaryWorkModel objects:');
    }

    return sanitaryWork;
  }
  Future<void> fetchAndSaveSanitaryWorkData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlSanitaryWorkMosque}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      SanitaryWorkModel model = SanitaryWorkModel.fromMap(item);
      await dbClient.insert(tableNameSanitaryWorkMosque, model.toMap());
    }
  }
  Future<List<SanitaryWorkModel>> getUnPostedSanitaryWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameSanitaryWorkMosque,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<SanitaryWorkModel> sanitaryWork = maps.map((map) => SanitaryWorkModel.fromMap(map)).toList();
    return sanitaryWork;
  }
  Future<int>add(SanitaryWorkModel sanitaryWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameSanitaryWorkMosque,sanitaryWorkModel.toMap());
  }

  Future<int>update(SanitaryWorkModel sanitaryWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameSanitaryWorkMosque,sanitaryWorkModel.toMap(),
        where: 'id = ?', whereArgs: [sanitaryWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameSanitaryWorkMosque,
        where: 'id = ?', whereArgs: [id]);
  }
}