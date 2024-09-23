
import 'dart:convert';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/mud_filling_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/mud_filling_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class MudFillingWorkViewModel extends GetxController {

  var allMud = <MudFillingWorkModel>[].obs;
  MudFillingWorkRepository mudFillingWorkRepository = MudFillingWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMudFilling = await mudFillingWorkRepository.getUnPostedMudFilling();

      for (var mudFilling in unPostedMudFilling) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMudFillingToAPI(mudFilling);

          // Step 3: If successful, update the posted status in the local database
          mudFilling.posted = 1;
          await mudFillingWorkRepository.update(mudFilling);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MudFilling with id ${mudFilling.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MudFilling with id ${mudFilling.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MudFilling: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMudFillingToAPI(MudFillingWorkModel mudFillingWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MudFillingWork Post API: ${Config.postApiUrlMudFillingWorkFountainPark}');
      var mudFillingWorkModelData = mudFillingWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlMudFillingWorkFountainPark),         headers: {
        "Content-Type": "application/json",  // Set the request content type to JSON
        "Accept": "application/json",
      },
        body: jsonEncode(mudFillingWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MudFilling data posted successfully: $mudFillingWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MudFilling data: $e');
      throw Exception('Failed to post data: $e');
    }
  }
  fetchAllMud() async{
    var mud = await mudFillingWorkRepository.getMudFillingWork();
    allMud.value = mud;

  }

  addMud(MudFillingWorkModel mudFillingWorkModel){
    mudFillingWorkRepository.add(mudFillingWorkModel);

  }

  updateMud(MudFillingWorkModel mudFillingWorkModel){
    mudFillingWorkRepository.update(mudFillingWorkModel);
    fetchAllMud();
  }

  deleteMud(int id){
    mudFillingWorkRepository.delete(id);
    fetchAllMud();
  }

}

