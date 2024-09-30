
import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BlocksDetailsModels/blocks_details_models.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class BlockDetailsRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<BlocksDetailsModels>> getBlockDetails() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameBlocksDetails,
        columns: ['id', 'block', 'marla','plot_no','user_id']
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
    List<BlocksDetailsModels> blocksDetails = [];
    for (int i = 0; i < maps.length; i++) {
      blocksDetails.add(BlocksDetailsModels.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed BlocksDetailsModels objects:');
    }

    return blocksDetails;
  }
  Future<void> fetchAndSaveBlockDetails() async {
    List<dynamic> data = await ApiService.getData(Config.getApiUrlBlocksDetails);
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      BlocksDetailsModels model = BlocksDetailsModels.fromMap(item);
      await dbClient.insert(tableNameBlocksDetails, model.toMap());
    }
  }

  Future<int>add(BlocksDetailsModels blocksDetailsModels) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameBlocksDetails,blocksDetailsModels.toMap());
  }

  Future<int>update(BlocksDetailsModels blocksDetailsModels) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameBlocksDetails,blocksDetailsModels.toMap(),
        where: 'id = ?', whereArgs: [blocksDetailsModels.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameBlocksDetails,
        where: 'id = ?', whereArgs: [id]);
  }
}