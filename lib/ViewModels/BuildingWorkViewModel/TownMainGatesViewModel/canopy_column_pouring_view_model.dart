
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/canopy_column_pouring_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/TownMainGatesRepository/canopy_column_pouring_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class CanopyColumnPouringViewModel extends GetxController {

  var allCanopy = <CanopyColumnPouringModel>[].obs;
  CanopyColumnPouringRepository canopyColumnPouringRepository = CanopyColumnPouringRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedCanopyColumnPouring = await canopyColumnPouringRepository.getUnPostedCanopyColumnPouring();

      for (var canopyColumnPouring in unPostedCanopyColumnPouring) {
        try {
          // Step 2: Attempt to post the data to the API
          await postCanopyColumnPouringToAPI(canopyColumnPouring);

          // Step 3: If successful, update the posted status in the local database
          canopyColumnPouring.posted = 1;
          await canopyColumnPouringRepository.update(canopyColumnPouring);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('CanopyColumnPouring with id ${canopyColumnPouring.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post CanopyColumnPouring with id ${canopyColumnPouring.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted CanopyColumnPouring: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postCanopyColumnPouringToAPI(CanopyColumnPouringModel canopyColumnPouringModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated CanopyColumnPouring Post API: ${Config.postApiUrlMainGateCanopyColumnPouringWork}');
      var canopyColumnPouringModelData = canopyColumnPouringModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlMainGateCanopyColumnPouringWork),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(canopyColumnPouringModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('CanopyColumnPouring data posted successfully: $canopyColumnPouringModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting CanopyColumnPouring data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllCanopy() async{
    var canopy = await canopyColumnPouringRepository.getCanopyColumnPouring();
    allCanopy.value = canopy;

  }

  addCanopy(CanopyColumnPouringModel canopyColumnPouringModel){
    canopyColumnPouringRepository.add(canopyColumnPouringModel);

  }

  updateCanopy(CanopyColumnPouringModel canopyColumnPouringModel){
    canopyColumnPouringRepository.update(canopyColumnPouringModel);
    fetchAllCanopy();
  }

  deleteCanopy(int id){
    canopyColumnPouringRepository.delete(id);
    fetchAllCanopy();
  }

}

