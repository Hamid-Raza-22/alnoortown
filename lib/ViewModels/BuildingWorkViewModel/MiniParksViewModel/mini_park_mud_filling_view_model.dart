
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mini_park_mud_filling_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/mini_park_mud_filling_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class MiniParkMudFillingViewModel extends GetxController {

  var allMpMud = <MiniParkMudFillingModel>[].obs;
  MiniParkMudFillingRepository miniParkMudFillingRepository = MiniParkMudFillingRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMudFillingMp = await miniParkMudFillingRepository.getUnPostedMudFillingMp();

      for (var mudFillingMp in unPostedMudFillingMp) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMudFillingMpToAPI(mudFillingMp);

          // Step 3: If successful, update the posted status in the local database
          mudFillingMp.posted = 1;
          await miniParkMudFillingRepository.update(mudFillingMp);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MudFillingMiniPark with id ${mudFillingMp.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MudFillingMiniPark with id ${mudFillingMp.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MudFillingMiniPark: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMudFillingMpToAPI(MiniParkMudFillingModel miniParkMudFillingModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MudFillingMiniPark Post API: ${Config.postApiUrlMudFillingMiniPark}');
      var miniParkMudFillingModelData = miniParkMudFillingModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlMudFillingMiniPark),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(miniParkMudFillingModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MiniParkMudFilling data posted successfully: $miniParkMudFillingModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MudFillingMiniPark data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllMpMud() async{
    var mpMud = await miniParkMudFillingRepository.getMiniParkMudFilling();
    allMpMud.value = mpMud;

  }
  fetchAndSaveMiniParkMudFillingData() async {
    await miniParkMudFillingRepository.fetchAndSaveMiniParkMudFillingData();
  }
  addMpMud(MiniParkMudFillingModel miniParkMudFillingModel){
    miniParkMudFillingRepository.add(miniParkMudFillingModel);

  }

  updateMpMud(MiniParkMudFillingModel miniParkMudFillingModel){
    miniParkMudFillingRepository.update(miniParkMudFillingModel);
    fetchAllMpMud();
  }

  deleteMpMud(int id){
    miniParkMudFillingRepository.delete(id);
    fetchAllMpMud();
  }

}

