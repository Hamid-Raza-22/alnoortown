
import 'dart:convert';

import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/main_stage_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/main_stage_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class MainStageWorkViewModel extends GetxController {

  var allStage = <MainStageWorkModel>[].obs;
  MainStageWorkRepository mainStageWorkRepository = MainStageWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMainStage = await mainStageWorkRepository.getUnPostedMainStage();

      for (var mainStageWork in unPostedMainStage) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMainStageWorkToAPI(mainStageWork);

          // Step 3: If successful, update the posted status in the local database
          mainStageWork.posted = 1;
          await mainStageWorkRepository.update(mainStageWork);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MainStageWork with id ${mainStageWork.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MainStageWork with id ${mainStageWork.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MainStageWork: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMainStageWorkToAPI(MainStageWorkModel mainStageWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MainStage Post API: ${Config.postApiUrlWaterTanker}');
      var mainStageWorkModelData = mainStageWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(mainStageWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MainStageWork data posted successfully: $mainStageWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MainStageWork data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllStage() async{
    var stage = await mainStageWorkRepository.getMainStageWork();
    allStage.value = stage;

  }

  addStage(MainStageWorkModel mainStageWorkModel){
    mainStageWorkRepository.add(mainStageWorkModel);

  }

  updateStage(MainStageWorkModel mainStageWorkModel){
    mainStageWorkRepository.update(mainStageWorkModel);
    fetchAllStage();
  }

  deleteStage(int id){
    mainStageWorkRepository.delete(id);
    fetchAllStage();
  }

}

