
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/asphalt_work_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/asphalt_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class AsphaltWorkViewModel extends GetxController {

  var allAsphalt = <AsphaltWorkModel>[].obs;
  AsphaltWorkRepository asphaltWorkRepository = AsphaltWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllAsphalt();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedAsphalt = await asphaltWorkRepository.getUnPostedAsphaltWork();

      for (var asphalt in unPostedAsphalt) {
        try {
          // Step 2: Attempt to post the data to the API
          await postAsphaltToAPI(asphalt);

          // Step 3: If successful, update the posted status in the local database
          asphalt.posted = 1;
          await asphaltWorkRepository.update(asphalt);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('Asphalt with id ${asphalt.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post Asphalt with id ${asphalt.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted Asphalt: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postAsphaltToAPI(AsphaltWorkModel asphaltWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated Asphalt Post API: ${Config.postApiUrlAsphaltWork}');
      var asphaltWorkModelData = asphaltWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlAsphaltWork),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(asphaltWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Asphalt data posted successfully: $asphaltWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting Asphalt data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllAsphalt() async{
    var asphalts = await asphaltWorkRepository.getAsphaltWork();
    allAsphalt .value = asphalts;

  }

  addAsphalt(AsphaltWorkModel asphaltWorkModel){
    asphaltWorkRepository.add(asphaltWorkModel);
    //fetchAllAsphalt();
  }

  updateAsphalt(AsphaltWorkModel asphaltWorkModel){
    asphaltWorkRepository.update(asphaltWorkModel);
    fetchAllAsphalt();
  }

  deleteAsphalt(int id){
    asphaltWorkRepository.delete(id);
    fetchAllAsphalt();
  }

}

