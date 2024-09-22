
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/sanitary_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/sanitary_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class SanitaryWorkViewModel extends GetxController {

  var allSanitary = <SanitaryWorkModel>[].obs;
  SanitaryWorkRepository sanitaryWorkRepository = SanitaryWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedSanitaryWorks = await sanitaryWorkRepository.getUnPostedSanitaryWork();

      for (var sanitaryWorks in unPostedSanitaryWorks) {
        try {
          // Step 2: Attempt to post the data to the API
          await postSanitaryWorksToAPI(sanitaryWorks);

          // Step 3: If successful, update the posted status in the local database
          sanitaryWorks.posted = 1;
          await sanitaryWorkRepository.update(sanitaryWorks);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('SanitaryWorks with id ${sanitaryWorks.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post SanitaryWorks with id ${sanitaryWorks.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted SanitaryWorks: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postSanitaryWorksToAPI(SanitaryWorkModel sanitaryWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated SanitaryWorks Post API: ${Config.postApiUrlSanitaryWorkMosque}');
      var sanitaryWorkModelData = sanitaryWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlSanitaryWorkMosque),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(sanitaryWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('SanitaryWorks data posted successfully: $sanitaryWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting SanitaryWorks data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllSanitary() async{
    var sanitaryJob = await sanitaryWorkRepository.getSanitaryWork();
    allSanitary.value = sanitaryJob;

  }

  addSanitary(SanitaryWorkModel sanitaryWorkModel){
    sanitaryWorkRepository.add(sanitaryWorkModel);

  }

  updateSanitary(SanitaryWorkModel sanitaryWorkModel){
    sanitaryWorkRepository.update(sanitaryWorkModel);
    fetchAllSanitary();
  }

  deleteSanitary(int id){
    sanitaryWorkRepository.delete(id);
    fetchAllSanitary();
  }

}

