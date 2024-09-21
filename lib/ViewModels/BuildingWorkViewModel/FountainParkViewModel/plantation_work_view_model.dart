
import 'dart:convert';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/plantation_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/plantation_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PlantationWorkViewModel extends GetxController {
  var allPlant = <PlantationWorkModel>[].obs;
  PlantationWorkRepository plantationWorkRepository = PlantationWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPlantation = await plantationWorkRepository.getUnPostedPlantation();

      for (var plantationWork in unPostedPlantation) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPlantationWorkToAPI(plantationWork);

          // Step 3: If successful, update the posted status in the local database
          plantationWork.posted = 1;
          await plantationWorkRepository.update(plantationWork);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('PlantationWork with id ${plantationWork.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post PlantationWork with id ${plantationWork.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted PlantationWork: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postPlantationWorkToAPI(PlantationWorkModel plantationWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated PlantationWork Post API: ${Config.waterTankerPostApi}');
      var plantationWorkModelData = plantationWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.waterTankerPostApi),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(plantationWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('PlantationWork data posted successfully: $plantationWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting PlantationWork data: $e');
      throw Exception('Failed to post data: $e');
    }
  }
  fetchAllPlant() async{
    var plant = await plantationWorkRepository.getPlantationWork();
    allPlant.value = plant;

  }

  addPlant(PlantationWorkModel plantationWorkModel){
    plantationWorkRepository.add(plantationWorkModel);

  }

  updatePlant(PlantationWorkModel plantationWorkModel){
    plantationWorkRepository.update(plantationWorkModel);
    fetchAllPlant();
  }

  deleteMud(int id){
    plantationWorkRepository.delete(id);
    fetchAllPlant();
  }

}

