
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/monuments_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/monuments_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class MonumentsWorkViewModel extends GetxController {

  var allMonument = <MonumentsWorkModel>[].obs;
  MonumentsWorkRepository monumentsWorkRepository = MonumentsWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMonuments = await monumentsWorkRepository.getUnPostedMonumentWork();

      for (var monument in unPostedMonuments) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMonumentsToAPI(monument);

          // Step 3: If successful, update the posted status in the local database
          monument.posted = 1;
          await monumentsWorkRepository.update(monument);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('Monuments with id ${monument.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post Monuments with id ${monument.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted Monuments: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMonumentsToAPI(MonumentsWorkModel monumentsWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated Monuments Post API: ${Config.postApiUrlMonumentWork}');
      var monumentsWorkModelData = monumentsWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlMonumentWork),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(monumentsWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Monuments data posted successfully: $monumentsWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting Monuments data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllMonument() async{
    var monument = await monumentsWorkRepository.getMonumentsWork();
    allMonument.value = monument;

  }
  fetchAndSaveMonumentData() async {
    await monumentsWorkRepository.fetchAndSaveMonumentWorkData();
  }
  addMonument(MonumentsWorkModel monumentsWorkModel){
    monumentsWorkRepository.add(monumentsWorkModel);

  }

  updateMonument(MonumentsWorkModel monumentsWorkModel){
    monumentsWorkRepository.update(monumentsWorkModel);
    fetchAllMonument();
  }

  deleteMonument(int id){
    monumentsWorkRepository.delete(id);
    fetchAllMonument();
  }

}

