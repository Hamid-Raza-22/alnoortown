
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/manholes_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/SewerageWorksRepositries/manholes_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
class ManholesViewModel extends GetxController {

  var allWorker = <ManholesModel>[].obs;
  ManholesRepository manholesRepository = ManholesRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllWorker ();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedManholesSewerageWorks = await manholesRepository.getUnPostedManHolesSewerageWorks();

      for (var manholesSewerageWorks  in unPostedManholesSewerageWorks) {
        try {
          // Step 2: Attempt to post the data to the API
          await postManholesSewerageWorksToAPI(manholesSewerageWorks);

          // Step 3: If successful, update the posted status in the local database
          manholesSewerageWorks.posted = 1;
          await manholesRepository.update(manholesSewerageWorks);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('ManholesSewerageWorks with id ${manholesSewerageWorks.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post ManholesSewerageWorks with id ${manholesSewerageWorks.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted ManholesSewerageWorks: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postManholesSewerageWorksToAPI(ManholesModel manholesModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated ManholesSewerageWorks Post API: ${Config.postApiUrlManholes}');
      var manholesModelData = manholesModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlManholes),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(manholesModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('ManholesSewerageWorks data posted successfully: $manholesModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting ManholesSewerageWorks data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllWorker() async{
    var slab = await manholesRepository.getManholes();
    allWorker .value = slab;

  }

  addWorker(ManholesModel manholesModel){
    manholesRepository.add(manholesModel);
    //fetchAllWorker();
  }

  updateWorker(ManholesModel manholesModel){
    manholesRepository.update(manholesModel);
    fetchAllWorker();
  }

  deleteWorker(int id){
    manholesRepository.delete(id);
    fetchAllWorker();
  }

}

