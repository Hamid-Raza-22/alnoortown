
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/tiles_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/tiles_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class TilesWorkViewModel extends GetxController {

  var allTiles = <TilesWorkModel>[].obs;
  TilesWorkRepository tilesWorkRepository = TilesWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedTilesWorks = await tilesWorkRepository.getUnPostedTilesWork();

      for (var tilesWorks in unPostedTilesWorks) {
        try {
          // Step 2: Attempt to post the data to the API
          await postTilesWorksToAPI(tilesWorks);

          // Step 3: If successful, update the posted status in the local database
          tilesWorks.posted = 1;
          await tilesWorkRepository.update(tilesWorks);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('TilesWorks  with id ${tilesWorks.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post TilesWorks  with id ${tilesWorks.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted TilesWorks : $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postTilesWorksToAPI(TilesWorkModel tilesWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated TilesWorks  Post API: ${Config.postApiUrlTilesWorkMosque}');
      var tilesWorkModelData = tilesWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlTilesWorkMosque),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(tilesWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('TilesWorks  data posted successfully: $tilesWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting TilesWorks  data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllTiles() async{
    var tilesJob = await tilesWorkRepository.getTilesWork();
    allTiles.value = tilesJob;

  }
  fetchAndSaveTilesWorkData() async {
    await tilesWorkRepository.fetchAndSaveTilesWorkData();
  }
  addTiles(TilesWorkModel tilesWorkModel){
    tilesWorkRepository.add(tilesWorkModel);

  }

  updateTiles(TilesWorkModel tilesWorkModel){
    tilesWorkRepository.update(tilesWorkModel);
    fetchAllTiles();
  }

  deleteTiles(int id){
    tilesWorkRepository.delete(id);
    fetchAllTiles();
  }

}

