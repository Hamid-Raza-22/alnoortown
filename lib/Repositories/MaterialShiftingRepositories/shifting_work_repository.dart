import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/MaterialShiftingModels/shifting_work_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class ShiftingWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ShiftingWorkModel>> getShiftingWork() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameShiftingWork,
        columns: ['id', 'from_block', 'to_block', 'no_of_shift','shifting_work_date','time','posted','user_id']
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
    List<ShiftingWorkModel> shiftingWork = [];
    for (int i = 0; i < maps.length; i++) {
      shiftingWork.add(ShiftingWorkModel.fromMap(maps[i]));
    }

    // Print the list of MachineModel objects
    if (kDebugMode) {
      print('Parsed ShiftingWorkModel objects:');
    }
    return shiftingWork;
  }
  Future<void> fetchAndSaveShiftingWorkData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlShiftingWork}$userId');
    var dbClient = await dbHelper.db;


    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      ShiftingWorkModel model = ShiftingWorkModel.fromMap(item);
      await dbClient.insert(tableNameShiftingWork, model.toMap());
    }
  }
  Future<List<ShiftingWorkModel>> getUnPostedShiftingWork() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameShiftingWork,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<ShiftingWorkModel> shiftingWork = maps.map((map) => ShiftingWorkModel.fromMap(map)).toList();
    return shiftingWork;
  }
  Future<int>add(ShiftingWorkModel shiftingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameShiftingWork,shiftingWorkModel.toMap());
  }

  Future<int>update(ShiftingWorkModel shiftingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameShiftingWork,shiftingWorkModel.toMap(),
        where: 'id = ?', whereArgs: [shiftingWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameShiftingWork,
        where: 'id = ?', whereArgs: [id]);
  }
}