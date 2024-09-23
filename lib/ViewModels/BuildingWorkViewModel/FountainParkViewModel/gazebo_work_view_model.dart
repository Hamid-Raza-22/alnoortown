
import 'dart:convert';

import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/gazebo_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/gazebo_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class GazeboWorkViewModel extends GetxController {

  var allGazebo = <GazeboWorkModel>[].obs;
  GazeboWorkRepository gazeboWorkRepository = GazeboWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedGazeboWork = await gazeboWorkRepository.getUnPostedGazebo();

      for (var gazeboWork in unPostedGazeboWork) {
        try {
          // Step 2: Attempt to post the data to the API
          await postGazeboWorkToAPI(gazeboWork);

          // Step 3: If successful, update the posted status in the local database
          gazeboWork.posted = 1;
          await gazeboWorkRepository.update(gazeboWork);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('GazeboWork with id ${gazeboWork.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post GazeboWork with id ${gazeboWork.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted GazeboWork: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postGazeboWorkToAPI(GazeboWorkModel gazeboWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated GazeboWork Post API: ${Config.postApiUrlGazeboWork}');
      var gazeboWorkModelData = gazeboWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlGazeboWork),         headers: {
        "Content-Type": "application/json",  // Set the request content type to JSON
        "Accept": "application/json",
      },
        body: jsonEncode(gazeboWorkModelData),  // Encode the map as JSON
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        print('GazeboWork data posted successfully: $gazeboWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting GazeboWork data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllGazebo() async{
    var gazebo = await gazeboWorkRepository.getGazeboWork();
    allGazebo.value = gazebo;

  }

  addGazebo(GazeboWorkModel gazeboWorkModel){
    gazeboWorkRepository.add(gazeboWorkModel);

  }

  updateGazebo(GazeboWorkModel gazeboWorkModel){
    gazeboWorkRepository.update(gazeboWorkModel);
    fetchAllGazebo();
  }

  deleteGazebo(int id){
    gazeboWorkRepository.delete(id);
    fetchAllGazebo();
  }

}

