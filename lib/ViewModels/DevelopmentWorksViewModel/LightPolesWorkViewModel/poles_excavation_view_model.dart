import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_excavation_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/LightPolesWorkRepositories/poles_excavation_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class PolesExcavationViewModel extends GetxController {

  var allPoleExa = <PolesExcavationModel>[].obs;
  PolesExcavationRepository polesExcavationRepository = PolesExcavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllPoleExa();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPolesExcavation = await polesExcavationRepository.getUnPostedPolesExcavation();

      for (var polesExcavation in unPostedPolesExcavation) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPolesExcavationToAPI(polesExcavation);

          // Step 3: If successful, update the posted status in the local database
          polesExcavation.posted = 1;
          await polesExcavationRepository.update(polesExcavation);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('PolesExcavation with id ${polesExcavation.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post PolesExcavation with id ${polesExcavation.id}: $e');
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
  Future<void> postPolesExcavationToAPI(PolesExcavationModel polesExcavationModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated PolesExcavation Post API: ${Config.postApiUrlWaterTanker}');
      var polesExcavationModelData = polesExcavationModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(polesExcavationModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('PolesExcavation data posted successfully: $polesExcavationModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting PolesExcavation data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllPoleExa() async{
    var poles = await polesExcavationRepository.getPolesExcavation();
    allPoleExa .value = poles;

  }

  addPoleExa(PolesExcavationModel polesExcavationModel){
    polesExcavationRepository.add(polesExcavationModel);
    //fetchAllPoleExa();
  }

  updatePoleExa(PolesExcavationModel polesExcavationModel){
    polesExcavationRepository.update(polesExcavationModel);
    fetchAllPoleExa();
  }

  deletePoleExa(int id){
    polesExcavationRepository.delete(id);
    fetchAllPoleExa();
  }

}

