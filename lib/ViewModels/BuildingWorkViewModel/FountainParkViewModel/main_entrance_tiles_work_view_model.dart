
import 'dart:convert';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/main_entrance_tiles_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/main_entrance_tiles_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class MainEntranceTilesWorkViewModel extends GetxController {

  var allEntrance = <MainEntranceTilesWorkModel>[].obs;
  MainEntranceTilesWorkRepository mainEntranceTilesWorkRepository = MainEntranceTilesWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMainEntranceTiles = await mainEntranceTilesWorkRepository.getUnPostedMainEntranceTiles();

      for (var mainEntranceTiles in unPostedMainEntranceTiles) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMainEntranceTilesToAPI(mainEntranceTiles);

          // Step 3: If successful, update the posted status in the local database
          mainEntranceTiles.posted = 1;
          await mainEntranceTilesWorkRepository.update(mainEntranceTiles);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MainEntranceTiles with id ${mainEntranceTiles.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MainEntranceTiles with id ${mainEntranceTiles.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MainEntranceTiles: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMainEntranceTilesToAPI(MainEntranceTilesWorkModel mainEntranceTilesWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MainEntranceTilesWork Post API: ${Config.postApiUrlMainEntranceTilesWork}');
      var mainEntranceTilesWorkModelData = mainEntranceTilesWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlMainEntranceTilesWork),         headers: {
        "Content-Type": "application/json",  // Set the request content type to JSON
        "Accept": "application/json",
      },
        body: jsonEncode(mainEntranceTilesWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MainEntranceTiles data posted successfully: $mainEntranceTilesWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MainEntranceTiles data: $e');
      throw Exception('Failed to post data: $e');
    }
  }
  fetchAllEntrance() async{
    var entrance = await mainEntranceTilesWorkRepository.getMainEntranceTilesWork();
    allEntrance.value = entrance;

  }

  addEntrance(MainEntranceTilesWorkModel mainEntranceTilesWorkModel){
    mainEntranceTilesWorkRepository.add(mainEntranceTilesWorkModel);

  }

  updateEntrance(MainEntranceTilesWorkModel mainEntranceTilesWorkModel){
    mainEntranceTilesWorkRepository.update(mainEntranceTilesWorkModel);
    fetchAllEntrance();
  }

  deleteEntrance(int id){
    mainEntranceTilesWorkRepository.delete(id);
    fetchAllEntrance();
  }

}

