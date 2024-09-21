
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/main_gate_pillar_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/TownMainGatesRepository/main_gate_pillar_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class MainGatePillarWorkViewModel extends GetxController {

  var allMainPillar = <MainGatePillarWorkModel>[].obs;
  MainGatePillarWorkRepository mainGatePillarWorkRepository = MainGatePillarWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMainGatePillar = await mainGatePillarWorkRepository.getUnPostedMainGatePillarWork();

      for (var mainGatePillar in unPostedMainGatePillar) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMainGatePillarToAPI(mainGatePillar);

          // Step 3: If successful, update the posted status in the local database
          mainGatePillar.posted = 1;
          await mainGatePillarWorkRepository.update(mainGatePillar);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MainGatePillar with id ${mainGatePillar.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MainGatePillar with id ${mainGatePillar.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MainGatePillar: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMainGatePillarToAPI(MainGatePillarWorkModel mainGatePillarWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MainGatePillar Post API: ${Config.postApiUrlWaterTanker}');
      var mainGatePillarWorkModelData = mainGatePillarWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(mainGatePillarWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MainGatePillar data posted successfully: $mainGatePillarWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MainGatePillar data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllMainPillar() async{
    var mainPillar = await mainGatePillarWorkRepository.getMainGatePillarWork();
    allMainPillar.value = mainPillar;

  }

  addMainPillar(MainGatePillarWorkModel mainGatePillarWorkModel){
    mainGatePillarWorkRepository.add(mainGatePillarWorkModel);

  }

  updateMainPillar(MainGatePillarWorkModel mainGatePillarWorkModel){
    mainGatePillarWorkRepository.update(mainGatePillarWorkModel);
    fetchAllMainPillar();
  }

  deleteMainPillar(int id){
    mainGatePillarWorkRepository.delete(id);
    fetchAllMainPillar();
  }

}

