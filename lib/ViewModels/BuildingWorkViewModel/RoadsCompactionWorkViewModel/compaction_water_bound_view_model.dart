
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/compaction_water_bound_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsCompactionWorkRepository/compaction_water_bound_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class CompactionWaterBoundViewModel extends GetxController {

  var allWaterBound = <CompactionWaterBoundModel>[].obs;
  CompactionWaterBoundRepository compactionWaterBoundRepository = CompactionWaterBoundRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedCompactionWaterBound = await compactionWaterBoundRepository.getUnPostedCompactionWaterBound();

      for (var compactionWaterBound in unPostedCompactionWaterBound) {
        try {
          // Step 2: Attempt to post the data to the API
          await postCompactionWaterBoundToAPI(compactionWaterBound);

          // Step 3: If successful, update the posted status in the local database
          compactionWaterBound.posted = 1;
          await compactionWaterBoundRepository.update(compactionWaterBound);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('CompactionWaterBound with id ${compactionWaterBound.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post CompactionWaterBound with id ${compactionWaterBound.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted CompactionWaterBound: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postCompactionWaterBoundToAPI(CompactionWaterBoundModel compactionWaterBoundModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated CompactionWaterBound Post API: ${Config.postApiUrlWaterTanker}');
      var compactionWaterBoundModelData = compactionWaterBoundModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(compactionWaterBoundModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('CompactionWaterBound data posted successfully: $compactionWaterBoundModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting CompactionWaterBound data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllWaterBound() async{
    var waterBound = await compactionWaterBoundRepository.getCompactionWaterBound();
    allWaterBound.value = waterBound;

  }

  addWaterBound(CompactionWaterBoundModel compactionWaterBoundModel){
    compactionWaterBoundRepository.add(compactionWaterBoundModel);

  }

  updateWaterBound(CompactionWaterBoundModel compactionWaterBoundModel){
    compactionWaterBoundRepository.update(compactionWaterBoundModel);
    fetchAllWaterBound();
  }

  deleteWaterBound(int id){
    compactionWaterBoundRepository.delete(id);
    fetchAllWaterBound();
  }

}

