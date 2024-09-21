
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/main_drain_excavation_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/main_drain_excavation_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class MainDrainExcavationViewModel extends GetxController {

  var allDrain = <MainDrainExcavationModel>[].obs;
  MainDrainExcavationRepository mainDrainExcavationRepository = MainDrainExcavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllDrain();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMainDrainExcavation = await mainDrainExcavationRepository.getUnPostedMainDrainExcavation();

      for (var mainDrainExcavation in unPostedMainDrainExcavation) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMainDrainExcavationToAPI(mainDrainExcavation);

          // Step 3: If successful, update the posted status in the local database
          mainDrainExcavation.posted = 1;
          await mainDrainExcavationRepository.update(mainDrainExcavation);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MainDrainExcavation with id ${mainDrainExcavation.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MainDrainExcavation with id ${mainDrainExcavation.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MainDrainExcavation: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMainDrainExcavationToAPI(MainDrainExcavationModel mainDrainExcavationModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MainDrainExcavation Post API: ${Config.postApiUrlWaterTanker}');
      var mainDrainExcavationModelData = mainDrainExcavationModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(mainDrainExcavationModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MainDrainExcavation data posted successfully: $mainDrainExcavationModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MainDrainExcavation data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllDrain() async{
    var main = await mainDrainExcavationRepository.getMainDrainExcavation();
    allDrain .value = main;

  }

  addWork(MainDrainExcavationModel mainDrainExcavationModel){
    mainDrainExcavationRepository.add(mainDrainExcavationModel);
    //fetchAllDrain();
  }

  updateWork(MainDrainExcavationModel mainDrainExcavationModel){
    mainDrainExcavationRepository.update(mainDrainExcavationModel);
    fetchAllDrain();
  }

  deleteWork(int id){
    mainDrainExcavationRepository.delete(id);
    fetchAllDrain();
  }

}

