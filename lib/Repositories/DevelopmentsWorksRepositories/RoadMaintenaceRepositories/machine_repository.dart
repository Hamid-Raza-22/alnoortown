
import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/machine_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';


class MachineRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MachineModel>> getMachine() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameMachine,
        columns: ['id', 'block_no', 'street_no', 'machine', 'time_in', 'time_out','machine_date','time','posted','user_id']
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
    List<MachineModel> machine = [];
    for (int i = 0; i < maps.length; i++) {
      machine.add(MachineModel.fromMap(maps[i]));
    }

    return machine;
  }
  Future<void> fetchAndSaveTankerData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlMachine}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      MachineModel model = MachineModel.fromMap(item);
      await dbClient.insert(tableNameWaterTanker, model.toMap());
    }
  }
  Future<List<MachineModel>> getUnPostedMachines() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameMachine,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<MachineModel> machines = maps.map((map) => MachineModel.fromMap(map)).toList();
    return machines;
  }

  Future<int>add(MachineModel machineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMachine,machineModel.toMap());
  }

  Future<int>update(MachineModel machineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMachine,machineModel.toMap(),
        where: 'id = ?', whereArgs: [machineModel.id]);

  }

  Future<int>delete(int? id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMachine,
        where: 'id = ?', whereArgs: [id]);
  }
}