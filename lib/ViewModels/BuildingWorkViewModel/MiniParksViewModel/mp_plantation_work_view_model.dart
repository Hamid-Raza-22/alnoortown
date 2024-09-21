
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mp_plantation_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/mp_plantation_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class MpPlantationWorkViewModel extends GetxController {

  var allMpPlant = <MpPlantationWorkModel>[].obs;
  MpPlantationWorkRepository mpPlantationWorkRepository = MpPlantationWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPlantationMiniPark = await mpPlantationWorkRepository.getUnPostedPlantationWorkMp();

      for (var plantationMiniPark in unPostedPlantationMiniPark) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPlantationMiniParkToAPI(plantationMiniPark);

          // Step 3: If successful, update the posted status in the local database
          plantationMiniPark.posted = 1;
          await mpPlantationWorkRepository.update(plantationMiniPark);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('PlantationMiniPark with id ${plantationMiniPark.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post PlantationMiniPark with id ${plantationMiniPark.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted PlantationMiniPark: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postPlantationMiniParkToAPI(MpPlantationWorkModel mpPlantationWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated PlantationMiniPark Post API: ${Config.waterTankerPostApi}');
      var mpPlantationWorkModelData = mpPlantationWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.waterTankerPostApi),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(mpPlantationWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('PlantationMiniPark data posted successfully: $mpPlantationWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting PlantationMiniPark data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllMpPlant() async{
    var mpPlant = await mpPlantationWorkRepository.getMpPlantationWork();
    allMpPlant.value = mpPlant;

  }

  addMpPlant(MpPlantationWorkModel mpPlantationWorkModel){
    mpPlantationWorkRepository.add(mpPlantationWorkModel);

  }

  updateMpPlant(MpPlantationWorkModel mpPlantationWorkModel){
    mpPlantationWorkRepository.update(mpPlantationWorkModel);
    fetchAllMpPlant();
  }

  deleteMpPlant(int id){
    mpPlantationWorkRepository.delete(id);
    fetchAllMpPlant();
  }

}

