import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../../../Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_foundation_model.dart';
import '../../../Repositories/DevelopmentsWorksRepositories/LightPolesWorkRepositories/poles_foundation_repository.dart';

class PolesFoundationViewModel extends GetxController {

  var allPoleExa = <PolesFoundationModel>[].obs;
  PolesFoundationRepository polesFoundationRepository = PolesFoundationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllPoleExa();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPolesExcavation = await polesFoundationRepository.getUnPostedPolesFoundation();

      for (var polesFoundation in unPostedPolesExcavation) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPolesFoundationToAPI(polesFoundation);

          // Step 3: If successful, update the posted status in the local database
          polesFoundation.posted = 1;
          await polesFoundationRepository.update(polesFoundation);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('PolesExcavation with id ${polesFoundation.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post PolesExcavation with id ${polesFoundation.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted PolesExcavation: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postPolesFoundationToAPI(PolesFoundationModel polesFoundationModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated PolesExcavation Post API: ${Config.postApiUrlPolesFoundation}');
      var polesFoundationModelData = polesFoundationModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlPolesFoundation),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(polesFoundationModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('PolesExcavation data posted successfully: $polesFoundationModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting PolesExcavation data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllPoleFoundation() async{
    var poles = await polesFoundationRepository.getPolesFoundation();
    allPoleExa .value = poles;

  }
  fetchAndSavePolesFoundationData() async {
    await polesFoundationRepository.fetchAndSavePolesFoundationData();
  }
  addPoleFoundation(PolesFoundationModel polesFoundationModel){
    polesFoundationRepository.add(polesFoundationModel);
    //fetchAllPoleExa();
  }

  updatePoleFoundation(PolesFoundationModel polesFoundationModel){
    polesFoundationRepository.update(polesFoundationModel);
    fetchAllPoleFoundation();
  }

  deletePolesFoundation(int id){
    polesFoundationRepository.delete(id);
    fetchAllPoleFoundation();
  }

}

