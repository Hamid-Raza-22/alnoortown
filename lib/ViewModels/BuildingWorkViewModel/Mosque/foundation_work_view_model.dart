
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/foundation_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/foundation_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class FoundationWorkViewModel extends GetxController {

  var allFoundation = <FoundationWorkModel>[].obs;
  FoundationWorkRepository foundationWorkRepository = FoundationWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedFoundationWorks = await foundationWorkRepository.getUnPostedFoundationWork();

      for (var foundationWorks in unPostedFoundationWorks) {
        try {
          // Step 2: Attempt to post the data to the API
          await postFoundationWorksToAPI(foundationWorks);

          // Step 3: If successful, update the posted status in the local database
          foundationWorks.posted = 1;
          await foundationWorkRepository.update(foundationWorks);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('FoundationWorks with id ${foundationWorks.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post FoundationWorks with id ${foundationWorks.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted FoundationWorks: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postFoundationWorksToAPI(FoundationWorkModel foundationWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated FoundationWorks Post API: ${Config.postApiUrlFoundationWorkMosque}');
      var foundationWorkModelData = foundationWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlFoundationWorkMosque),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(foundationWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('FoundationWorks data posted successfully: $foundationWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting FoundationWorks data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllFoundation() async{
    var foundation = await foundationWorkRepository.getFoundationWork();
    allFoundation.value = foundation;

  }

  addFoundation(FoundationWorkModel foundationWorkModel){
    foundationWorkRepository.add(foundationWorkModel);

  }

  updateFoundation(FoundationWorkModel foundationWorkModel){
    foundationWorkRepository.update(foundationWorkModel);
    fetchAllFoundation();
  }

  deleteFoundation(int id){
    foundationWorkRepository.delete(id);
    fetchAllFoundation();
  }

}

