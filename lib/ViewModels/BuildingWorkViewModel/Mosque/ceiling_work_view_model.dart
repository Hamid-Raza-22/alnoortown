import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/ceiling_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/ceiling_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class CeilingWorkViewModel extends GetxController {

  var allCeiling = <CeilingWorkModel>[].obs;
  CeilingWorkRepository ceilingWorkRepository = CeilingWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedCeilingWorks = await ceilingWorkRepository.getUnPostedCeilingWork();

      for (var ceilingWorks in unPostedCeilingWorks) {
        try {
          // Step 2: Attempt to post the data to the API
          await postCeilingWorksToAPI(ceilingWorks);

          // Step 3: If successful, update the posted status in the local database
          ceilingWorks.posted = 1;
          await ceilingWorkRepository.update(ceilingWorks);

          if (kDebugMode) {
            print('CeilingWorks with id ${ceilingWorks.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post CeilingWorks with id ${ceilingWorks.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted CeilingWorks: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postCeilingWorksToAPI(CeilingWorkModel ceilingWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated CeilingWorks Post API: ${Config.postApiUrlCeilingWorkMosque}');
      var ceilingWorkModelData = ceilingWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlCeilingWorkMosque),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(ceilingWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('CeilingWorks data posted successfully: $ceilingWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting CeilingWorks data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllCeiling() async{
    var ceiling = await ceilingWorkRepository.getCeilingWork();
    allCeiling.value = ceiling;

  }
  fetchAndSaveCeilingWorkData() async {
    await ceilingWorkRepository.fetchAndSaveCeilingWorkData();
  }
  addCeiling(CeilingWorkModel ceilingWorkModel){
    ceilingWorkRepository.add(ceilingWorkModel);

  }

  updateCeiling(CeilingWorkModel ceilingWorkModel){
    ceilingWorkRepository.update(ceilingWorkModel);
    fetchAllCeiling();
  }

  deleteCeiling(int id){
    ceilingWorkRepository.delete(id);
    fetchAllCeiling();
  }

}

