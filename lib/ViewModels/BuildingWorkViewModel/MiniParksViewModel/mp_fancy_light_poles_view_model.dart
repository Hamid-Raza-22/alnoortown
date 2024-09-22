
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mp_fancy_light_poles_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/mp_fancy_light_poles_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class MpFancyLightPolesViewModel extends GetxController {

  var allMpFancy = <MpFancyLightPolesModel>[].obs;
  MpFancyLightPolesRepository mpFancyLightPolesRepository = MpFancyLightPolesRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMiniParkFancyLightPoles = await mpFancyLightPolesRepository.getUnPostedFancyLightPolesMp();

      for (var miniParkFancyLightPoles in unPostedMiniParkFancyLightPoles) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMiniParkFancyLightPolesToAPI(miniParkFancyLightPoles);

          // Step 3: If successful, update the posted status in the local database
          miniParkFancyLightPoles.posted = 1;
          await mpFancyLightPolesRepository.update(miniParkFancyLightPoles);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MiniParkFancyLightPoles with id ${miniParkFancyLightPoles.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MiniParkFancyLightPoles with id ${miniParkFancyLightPoles.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MiniParkFancyLightPoles: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMiniParkFancyLightPolesToAPI(MpFancyLightPolesModel mpFancyLightPolesModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MiniParkFancyLightPoles Post API: ${Config.postApiUrlFancyLightPolesMiniPark}');
      var mpFancyLightPolesModelData = mpFancyLightPolesModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlFancyLightPolesMiniPark),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(mpFancyLightPolesModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MiniParkFancyLightPoles data posted successfully: $mpFancyLightPolesModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MiniParkFancyLightPoles data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllMpFancy() async{
    var mpFancy = await mpFancyLightPolesRepository.getMpFancyLightPoles();
    allMpFancy.value = mpFancy;

  }

  addMpFancy(MpFancyLightPolesModel mpFancyLightPolesModel){
    mpFancyLightPolesRepository.add(mpFancyLightPolesModel);

  }

  updateMpFancy(MpFancyLightPolesModel mpFancyLightPolesModel){
    mpFancyLightPolesRepository.update(mpFancyLightPolesModel);
    fetchAllMpFancy();
  }

  deleteMpFancy(int id){
    mpFancyLightPolesRepository.delete(id);
    fetchAllMpFancy();
  }

}

