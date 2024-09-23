
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/main_gate_foundation_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/TownMainGatesRepository/main_gate_foundation_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class MainGateFoundationWorkViewModel extends GetxController {

  var allMainFoundation = <MainGateFoundationWorkModel>[].obs;
  MainGateFoundationWorkRepository mainGateFoundationWorkRepository = MainGateFoundationWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMainGateFoundation = await mainGateFoundationWorkRepository.getUnPostedMainGateFoundation();

      for (var mainGateFoundation  in unPostedMainGateFoundation) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMainGateFoundationToAPI(mainGateFoundation);

          // Step 3: If successful, update the posted status in the local database
          mainGateFoundation.posted = 1;
          await mainGateFoundationWorkRepository.update(mainGateFoundation);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MainGateFoundation with id ${mainGateFoundation.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MainGateFoundation with id ${mainGateFoundation.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MainGateFoundation: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMainGateFoundationToAPI(MainGateFoundationWorkModel mainGateFoundationWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MainGateFoundation Post API: ${Config.postApiUrlFoundationWorkMainGate}');
      var mainGateFoundationWorkModelData = mainGateFoundationWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlFoundationWorkMainGate),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(mainGateFoundationWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MainGateFoundation data posted successfully: $mainGateFoundationWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MainGateFoundation data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllMainFoundation() async{
    var mainFoundation = await mainGateFoundationWorkRepository.getMainGateFoundationWork();
    allMainFoundation.value = mainFoundation;

  }

  addMainFoundation(MainGateFoundationWorkModel mainGateFoundationWorkModel){
    mainGateFoundationWorkRepository.add(mainGateFoundationWorkModel);

  }

  updateMainFoundation(MainGateFoundationWorkModel mainGateFoundationWorkModel){
    mainGateFoundationWorkRepository.update(mainGateFoundationWorkModel);
    fetchAllMainFoundation();
  }

  deleteMainFoundation(int id){
    mainGateFoundationWorkRepository.delete(id);
    fetchAllMainFoundation();
  }

}

