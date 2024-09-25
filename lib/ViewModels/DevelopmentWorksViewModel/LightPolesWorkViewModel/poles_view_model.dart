
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/LightPolesWorkRepositories/poles_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class PolesViewModel extends GetxController {

  var allPole = <PolesModel>[].obs;
  PolesRepository polesRepository = PolesRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
   // fetchAllPole();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPoles = await polesRepository.getUnPostedPoles();

      for (var poles in unPostedPoles) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPolesToAPI(poles);

          // Step 3: If successful, update the posted status in the local database
          poles.posted = 1;
          await polesRepository.update(poles);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('Poles with id ${poles.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post Poles with id ${poles.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted Poles: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postPolesToAPI(PolesModel polesModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated Poles Post API: ${Config.postApiUrlPoles}');
      var polesModelData = polesModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlPoles),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(polesModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Poles data posted successfully: $polesModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting Poles data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllPole() async{
    var poles = await polesRepository.getPoles();
    allPole .value = poles;

  }
  fetchAndSavePolesData() async {
    await polesRepository.fetchAndSavePolesWorkData();
  }

  addPole(PolesModel polesModel){
    polesRepository.add(polesModel);
    //fetchAllPole();
  }

  updatePole(PolesModel polesModel){
    polesRepository.update(polesModel);
    fetchAllPole();
  }

  deletePole(int id){
    polesRepository.delete(id);
    fetchAllPole();
  }

}

