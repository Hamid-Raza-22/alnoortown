

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/StreetRoadsWaterChannelsModel/street_road_water_channel_model.dart';
import 'package:flutter/foundation.dart';

class StreetRoadWaterChannelRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<StreetRoadWaterChannelModel>> getStreetRoadWaterChannel() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameStreetRoadWaterChannels,
        columns: ['id', 'blockNo', 'roadNo','roadSide','noOfWaterChannels','waterChCompStatus','date','time','posted']
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
  Future<List<StreetRoadWaterChannelModel>> getUnPostedMachines() async {
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