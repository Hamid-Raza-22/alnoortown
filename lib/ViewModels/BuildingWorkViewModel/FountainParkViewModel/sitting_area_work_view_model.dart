
import 'dart:convert';

import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/sitting_area_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/sitting_area_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class SittingAreaWorkViewModel extends GetxController {

  var allSitting = <SittingAreaWorkModel>[].obs;
  SittingAreaWorkRepository sittingAreaWorkRepository = SittingAreaWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedSittingArea = await sittingAreaWorkRepository.getUnPostedSittingArea();

      for (var sittingArea in unPostedSittingArea) {
        try {
          // Step 2: Attempt to post the data to the API
          await postSittingAreaWorkToAPI(sittingArea);

          // Step 3: If successful, update the posted status in the local database
          sittingArea.posted = 1;
          await sittingAreaWorkRepository.update(sittingArea);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('SittingArea with id ${sittingArea.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post SittingArea with id ${sittingArea.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted SittingArea: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postSittingAreaWorkToAPI(SittingAreaWorkModel sittingAreaWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated SittingArea Post API: ${Config.postApiUrlSittingAreaWork}');
      var sittingAreaWorkModelData = sittingAreaWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlSittingAreaWork),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(sittingAreaWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('SittingArea data posted successfully: $sittingAreaWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting SittingArea data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllSitting() async{
    var sitting = await sittingAreaWorkRepository.getSittingAreaWork();
    allSitting.value = sitting;

  }

  addSitting(SittingAreaWorkModel sittingAreaWorkModel){
    sittingAreaWorkRepository.add(sittingAreaWorkModel);

  }

  updateSitting(SittingAreaWorkModel sittingAreaWorkModel){
    sittingAreaWorkRepository.update(sittingAreaWorkModel);
    fetchAllSitting();
  }

  deleteSitting(int id){
    sittingAreaWorkRepository.delete(id);
    fetchAllSitting();
  }

}

