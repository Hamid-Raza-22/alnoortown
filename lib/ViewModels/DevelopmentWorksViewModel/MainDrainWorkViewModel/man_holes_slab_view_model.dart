
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/manholes_slab_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/manholes_slab_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class ManHolesSlabViewModel extends GetxController {

  var allMan = <ManholesSlabModel>[].obs;
  ManholesSlabRepository manholesSlabRepository = ManholesSlabRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllMan ();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedManholesSlab = await manholesSlabRepository.getUnPostedManHolesSlab();

      for (var manHolesSlab  in unPostedManholesSlab) {
        try {
          // Step 2: Attempt to post the data to the API
          await postManHolesSlabToAPI(manHolesSlab);

          // Step 3: If successful, update the posted status in the local database
          manHolesSlab.posted = 1;
          await manholesSlabRepository.update(manHolesSlab);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('ManHolesSlab with id ${manHolesSlab.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post ManHolesSlab with id ${manHolesSlab.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted ManHolesSlab: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postManHolesSlabToAPI(ManholesSlabModel manholesSlabModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated ManHolesSlab Post API: ${Config.postApiUrlWaterTanker}');
      var manholesSlabModelData = manholesSlabModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(manholesSlabModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('ManHolesSlab data posted successfully: $manholesSlabModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting ManHolesSlab data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllMan() async{
    var holes = await manholesSlabRepository.getManHolesSlab();
    allMan .value = holes;

  }

  addMan(ManholesSlabModel manholesSlabModel){
    manholesSlabRepository.add(manholesSlabModel);
    //fetchAllMan();
  }

  updateMan(ManholesSlabModel manholesSlabModel){
    manholesSlabRepository.update(manholesSlabModel);
    fetchAllMan();
  }

  deleteMan(int id){
    manholesSlabRepository.delete(id);
    fetchAllMan();
  }

}

