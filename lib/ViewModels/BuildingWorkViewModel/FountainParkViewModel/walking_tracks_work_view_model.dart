
import 'dart:convert';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/walking_tracks_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/walking_tracks_work_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class WalkingTracksWorkViewModel extends GetxController {

  var allWalking = <WalkingTracksWorkModel>[].obs;
  WalkingTracksWorkRepository walkingTracksWorkRepository = WalkingTracksWorkRepository();

  @override
  void onInit(){

    super.onInit();
  //   //fetchAllWalking();
  //
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedWalkingTracks = await walkingTracksWorkRepository.getUnPostedWalkingTrack();

      for (var walkingTracks in unPostedWalkingTracks) {
        try {
          // Step 2: Attempt to post the data to the API
          await postWalkingTracksToAPI(walkingTracks);

          // Step 3: If successful, update the posted status in the local database
          walkingTracks.posted = 1;
          await walkingTracksWorkRepository.update(walkingTracks);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('WalkingTracks with id ${walkingTracks.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post WalkingTracks with id ${walkingTracks.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted WalkingTracks: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postWalkingTracksToAPI(WalkingTracksWorkModel walkingTracksWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated WalkingTracks Post API: ${Config.waterTankerPostApi}');
      var walkingTracksWorkModelData = walkingTracksWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.waterTankerPostApi),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(walkingTracksWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('WalkingTracks data posted successfully: $walkingTracksWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting WalkingTracks data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllWalking() async{
    var walking = await walkingTracksWorkRepository.getWalkingTracksWork();
    allWalking.value = walking;

  }

  addWalking(WalkingTracksWorkModel walkingTracksWorkModel){
    walkingTracksWorkRepository.add(walkingTracksWorkModel);

  }

  updateWalking(WalkingTracksWorkModel walkingTracksWorkModel){
    walkingTracksWorkRepository.update(walkingTracksWorkModel);
    fetchAllWalking();
  }

  deleteWalking(int id){
    walkingTracksWorkRepository.delete(id);
    fetchAllWalking();
  }

}

