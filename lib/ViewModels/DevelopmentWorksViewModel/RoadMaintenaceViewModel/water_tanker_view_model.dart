
import 'dart:convert';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/water_tanker_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/RoadMaintenaceRepositories/water_tanker_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class WaterTankerViewModel extends GetxController {

  var allTanker = <WaterTankerModel>[].obs;
  WaterTankerRepository waterTankerRepository = WaterTankerRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllTanker ();
  }

  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedWaterTanker = await waterTankerRepository.getUnPostedWaterTanker();

      for (var waterTanker in unPostedWaterTanker) {
        try {
          // Step 2: Attempt to post the data to the API
          await postWaterTankerToAPI(waterTanker);

          // Step 3: If successful, update the posted status in the local database
          waterTanker.posted = 1;
          await waterTankerRepository.update(waterTanker);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('WaterTanker with id ${waterTanker.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post WaterTanker with id ${waterTanker.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted WaterTanker: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postWaterTankerToAPI(WaterTankerModel waterTankerModel) async {
    try {
      await Config.fetchLatestConfig();
      if (kDebugMode) {
        print('Updated Water Tanker Post API: ${Config.postApiUrlWaterTanker}');
      }
      var waterTankerModelData = waterTankerModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),         headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(waterTankerModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('WaterTanker data posted successfully: $waterTankerModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting WaterTanker data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllTanker() async{
    var tanker = await waterTankerRepository.getTanker();
    allTanker .value = tanker;

  }
  fetchAndSaveTankerData() async {
    await waterTankerRepository.fetchAndSaveTankerData();
  }
  addTanker(WaterTankerModel waterTankerModel){
    waterTankerRepository.add(waterTankerModel);
    //fetchAllTanker();
  }

  updateTanker(WaterTankerModel waterTankerModel){
    waterTankerRepository.update(waterTankerModel);
    fetchAllTanker();
  }

  deleteTanker(int id){
    waterTankerRepository.delete(id);
    fetchAllTanker();
  }

}

