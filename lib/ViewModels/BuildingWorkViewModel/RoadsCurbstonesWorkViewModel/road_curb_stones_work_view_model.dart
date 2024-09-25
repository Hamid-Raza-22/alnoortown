
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCurbstonesWorkModel/road_curb_stones_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsCurbStonesWorkRepuository/road_curb_stones_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class RoadCurbStonesWorkViewModel extends GetxController {

  var allRoadCurb = <RoadCurbStonesWorkModel>[].obs;
  RoadCurbStonesWorkRepository roadCurbStonesWorkRepository = RoadCurbStonesWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedRoadCurbStone = await roadCurbStonesWorkRepository.getUnPostedRoadCurbStones();

      for (var roadCurbStone in unPostedRoadCurbStone) {
        try {
          // Step 2: Attempt to post the data to the API
          await postRoadCurbStoneToAPI(roadCurbStone);

          // Step 3: If successful, update the posted status in the local database
          roadCurbStone.posted = 1;
          await roadCurbStonesWorkRepository.update(roadCurbStone);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('RoadCurbStone with id ${roadCurbStone.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post WaterTanker with id ${roadCurbStone.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted RoadCurbStone: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postRoadCurbStoneToAPI(RoadCurbStonesWorkModel roadCurbStonesWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated RoadCurbStone Post API: ${Config.postApiUrlRoadCurbStone}');
      var roadCurbStonesWorkModelData = roadCurbStonesWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlRoadCurbStone),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(roadCurbStonesWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('RoadCurbStone data posted successfully: $roadCurbStonesWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting RoadCurbStone data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllRoadCurb() async{
    var roadCurb = await roadCurbStonesWorkRepository.getRoadCurbStonesWork();
    allRoadCurb.value = roadCurb;

  }
  fetchAndSaveRoadsCurbStonesWorkData() async {
    await roadCurbStonesWorkRepository.fetchAndSaveRoadCompactionData();
  }
  addRoadCurb(RoadCurbStonesWorkModel roadCurbStonesWorkModel){
    roadCurbStonesWorkRepository.add(roadCurbStonesWorkModel);

  }

  updateRoadCurb(RoadCurbStonesWorkModel roadCurbStonesWorkModel){
    roadCurbStonesWorkRepository.update(roadCurbStonesWorkModel);
    fetchAllRoadCurb();
  }

  deleteRoadCurb(int id){
    roadCurbStonesWorkRepository.delete(id);
    fetchAllRoadCurb();
  }

}

