
import 'package:al_noor_town/Models/BuildingWorkModels/StreetRoadsWaterChannelsModel/street_road_water_channel_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/StreetRoadsWaterChannelsRepository/street_road_water_channel_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class StreetRoadWaterChannelViewModel extends GetxController {

  var allStreetRoad = <StreetRoadWaterChannelModel>[].obs;
  StreetRoadWaterChannelRepository streetRoadWaterChannelRepository = StreetRoadWaterChannelRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedStreetRoadsWaterChannels = await streetRoadWaterChannelRepository.getUnPostedStreetRoadWaterChannel();

      for (var streetRoadsWaterChannels in unPostedStreetRoadsWaterChannels) {
        try {
          // Step 2: Attempt to post the data to the API
          await postStreetRoadsWaterChannelsToAPI(streetRoadsWaterChannels);

          // Step 3: If successful, update the posted status in the local database
          streetRoadsWaterChannels.posted = 1;
          await streetRoadWaterChannelRepository.update(streetRoadsWaterChannels);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('StreetRoadsWaterChannels with id ${streetRoadsWaterChannels.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post StreetRoadsWaterChannels with id ${streetRoadsWaterChannels.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted StreetRoadsWaterChannels: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postStreetRoadsWaterChannelsToAPI(StreetRoadWaterChannelModel streetRoadWaterChannelModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated StreetRoadsWaterChannels Post API: ${Config.waterTankerPostApi}');
      var streetRoadWaterChannelModelData = streetRoadWaterChannelModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.waterTankerPostApi),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(streetRoadWaterChannelModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('StreetRoadsWaterChannels data posted successfully: $streetRoadWaterChannelModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting StreetRoadsWaterChannels data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllStreetRoad() async{
    var streetRoad = await streetRoadWaterChannelRepository.getStreetRoadWaterChannel();
    allStreetRoad.value = streetRoad;

  }

  addStreetRoad(StreetRoadWaterChannelModel streetRoadWaterChannelModel){
    streetRoadWaterChannelRepository.add(streetRoadWaterChannelModel);

  }

  updateStreetRoad(StreetRoadWaterChannelModel streetRoadWaterChannelModel){
    streetRoadWaterChannelRepository.update(streetRoadWaterChannelModel);
    fetchAllStreetRoad();
  }

  deleteStreetRoad(int id){
    streetRoadWaterChannelRepository.delete(id);
    fetchAllStreetRoad();
  }

}

