

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
        tableNameStreetRoadWCh,
        columns: ['id', 'blockNo', 'roadNo','roadSide','noOfWaterChannels','waterChCompStatus','date']
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

  Future<int>add(StreetRoadWaterChannelModel streetRoadWaterChannelModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameStreetRoadWCh,streetRoadWaterChannelModel.toMap());
  }

  Future<int>update(StreetRoadWaterChannelModel streetRoadWaterChannelModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameStreetRoadWCh,streetRoadWaterChannelModel.toMap(),
        where: 'id = ?', whereArgs: [streetRoadWaterChannelModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameStreetRoadWCh,
        where: 'id = ?', whereArgs: [id]);
  }
}