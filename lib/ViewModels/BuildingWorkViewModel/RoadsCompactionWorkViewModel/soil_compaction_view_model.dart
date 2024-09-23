
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/soil_compaction_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsCompactionWorkRepository/soil_compaction_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
class SoilCompactionViewModel extends GetxController {

  var allSoil = <SoilCompactionModel>[].obs;
  SoilCompactionRepository soilCompactionRepository = SoilCompactionRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedSoilCompaction = await soilCompactionRepository.getUnPostedSoilCompaction();

      for (var soilCompaction in unPostedSoilCompaction) {
        try {
          // Step 2: Attempt to post the data to the API
          await postSoilCompactionToAPI(soilCompaction);

          // Step 3: If successful, update the posted status in the local database
          soilCompaction.posted = 1;
          await soilCompactionRepository.update(soilCompaction);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('SoilCompaction with id ${soilCompaction.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post SoilCompaction with id ${soilCompaction.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted SoilCompaction: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postSoilCompactionToAPI(SoilCompactionModel soilCompactionModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated SoilCompaction Post API: ${Config.postApiUrlSoilCompaction}');
      var soilCompactionModelData = soilCompactionModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlSoilCompaction),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(soilCompactionModel),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('SoilCompaction data posted successfully: $soilCompactionModel');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting SoilCompaction data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllSoil() async{
    var soil = await soilCompactionRepository.getSoilCompaction();
    allSoil.value = soil;

  }

  addSoil(SoilCompactionModel soilCompactionModel){
    soilCompactionRepository.add(soilCompactionModel);

  }

  updateSoil(SoilCompactionModel soilCompactionModel){
    soilCompactionRepository.update(soilCompactionModel);
    fetchAllSoil();
  }

  deleteSoil(int id){
    soilCompactionRepository.delete(id);
    fetchAllSoil();
  }

}

