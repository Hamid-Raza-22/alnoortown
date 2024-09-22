import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import '../../../Models/DevelopmentsWorksModels/LightPolesWorkModels/light_wires_model.dart';
import '../../../Repositories/DevelopmentsWorksRepositories/LightPolesWorkRepositories/light_wires_repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class LightWiresViewModel extends GetxController {

  var allLight = <LightWiresModel>[].obs;
  LightWiresRepository lightWiresRepository = LightWiresRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllLight();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedLightPoles = await lightWiresRepository.getUnPostedLightWires();

      for (var lightPoles in unPostedLightPoles) {
        try {
          // Step 2: Attempt to post the data to the API
          await postLightWiresToAPI(lightPoles);

          // Step 3: If successful, update the posted status in the local database
          lightPoles.posted = 1;
          await lightWiresRepository.update(lightPoles);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('LightPoles with id ${lightPoles.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post LightPoles with id ${lightPoles.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted LightPoles: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postLightWiresToAPI(LightWiresModel lightWiresModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated LightPoles Post API: ${Config.postApiUrlLightWires}');
      var lightWiresModelData = lightWiresModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlLightWires),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(lightWiresModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('LightPoles data posted successfully: $lightWiresModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting LightPoles data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllLight() async{
    var light = await lightWiresRepository.getLightWires();
    allLight.value = light;

  }

  addLight(LightWiresModel lightWiresModel){
    lightWiresRepository.add(lightWiresModel);
    //fetchAllLight();
  }

  updateLight(LightWiresModel lightWiresModel){
    lightWiresRepository.update(lightWiresModel);
    fetchAllLight();
  }

  deleteLight(int id){
    lightWiresRepository.delete(id);
    fetchAllLight();
  }

}

