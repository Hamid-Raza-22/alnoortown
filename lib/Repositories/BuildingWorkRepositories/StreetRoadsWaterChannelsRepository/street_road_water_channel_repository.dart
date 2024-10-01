

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/StreetRoadsWaterChannelsModel/street_road_water_channel_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class StreetRoadWaterChannelRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<StreetRoadWaterChannelModel>> getStreetRoadWaterChannel() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameStreetRoadWaterChannels,
        columns: ['id', 'block_no', 'road_no','road_side','no_of_water_channels','water_channels_comp_status','street_roads_water_channel_date','time','posted','user_id']
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

    // Convert the raw data into a list of
    List<StreetRoadWaterChannelModel> streetRoadWaterChannel = [];
    for (int i = 0; i < maps.length; i++) {
      streetRoadWaterChannel.add(StreetRoadWaterChannelModel.fromMap(maps[i]));
    }

    // Print the list of
    if (kDebugMode) {
      print('Parsed StreetRoadWaterChannelModel objects:');
    }

    return streetRoadWaterChannel;
  }
  Future<void> fetchAndSaveStreetRoadsWaterChannelData() async {
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlStreetRoadWaterChannels}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      StreetRoadWaterChannelModel model = StreetRoadWaterChannelModel.fromMap(item);
      await dbClient.insert(tableNameStreetRoadWaterChannels, model.toMap());
    }
  }
  Future<List<StreetRoadWaterChannelModel>> getUnPostedStreetRoadWaterChannel() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameStreetRoadWaterChannels,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<StreetRoadWaterChannelModel> streetRoadWaterChannel = maps.map((map) => StreetRoadWaterChannelModel.fromMap(map)).toList();
    return streetRoadWaterChannel;
  }
  Future<int>add(StreetRoadWaterChannelModel streetRoadWaterChannelModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameStreetRoadWaterChannels,streetRoadWaterChannelModel.toMap());
  }

  Future<int>update(StreetRoadWaterChannelModel streetRoadWaterChannelModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameStreetRoadWaterChannels,streetRoadWaterChannelModel.toMap(),
        where: 'id = ?', whereArgs: [streetRoadWaterChannelModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameStreetRoadWaterChannels,
        where: 'id = ?', whereArgs: [id]);
  }
}