
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/sand_compaction_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsCompactionWorkRepository/sand_compaction_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class SandCompactionViewModel extends GetxController {

  var allSand = <SandCompactionModel>[].obs;
  SandCompactionRepository sandCompactionRepository = SandCompactionRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedSandCompaction = await sandCompactionRepository.getUnPostedSandCompaction();

      for (var sandCompaction  in unPostedSandCompaction) {
        try {
          // Step 2: Attempt to post the data to the API
          await postSandCompactionToAPI(sandCompaction);

          // Step 3: If successful, update the posted status in the local database
          sandCompaction.posted = 1;
          await sandCompactionRepository.update(sandCompaction);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('SandCompaction with id ${sandCompaction.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post SandCompaction with id ${sandCompaction.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted SandCompaction: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postSandCompactionToAPI(SandCompactionModel sandCompactionModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated SandCompaction Post API: ${Config.postApiUrlSandCompaction}');
      var sandCompactionModelData = sandCompactionModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlSandCompaction),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(sandCompactionModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('SandCompaction data posted successfully: $sandCompactionModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting SandCompaction data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllSand() async{
    var sand = await sandCompactionRepository.getSandCompaction();
    allSand.value = sand;

  }
  fetchAndSaveSandCompactionData() async {
    await sandCompactionRepository.fetchAndSaveSandCompactionData();
  }
  addSand(SandCompactionModel sandCompactionModel){
    sandCompactionRepository.add(sandCompactionModel);

  }

  updateSand(SandCompactionModel sandCompactionModel){
    sandCompactionRepository.update(sandCompactionModel);
    fetchAllSand();
  }

  deleteSand(int id){
    sandCompactionRepository.delete(id);
    fetchAllSand();
  }

}

