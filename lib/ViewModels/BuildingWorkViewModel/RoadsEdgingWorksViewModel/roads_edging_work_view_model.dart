
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsEdgingWorkModel/roads_edging_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsEdgingWorksRepository/roads_edging_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class RoadsEdgingWorkViewModel extends GetxController {

  var allRoadEdging = <RoadsEdgingWorkModel>[].obs;
  RoadsEdgingWorkRepository roadsEdgingWorkRepository = RoadsEdgingWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedRoadsEdging= await roadsEdgingWorkRepository.getUnPostedRoadsEdging();

      for (var roadsEdging in unPostedRoadsEdging) {
        try {
          // Step 2: Attempt to post the data to the API
          await postRoadsEdgingWorksToAPI(roadsEdging);

          // Step 3: If successful, update the posted status in the local database
          roadsEdging.posted = 1;
          await roadsEdgingWorkRepository.update(roadsEdging);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('RoadsEdging with id ${roadsEdging.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post RoadsEdging with id ${roadsEdging.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted RoadsEdging: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postRoadsEdgingWorksToAPI(RoadsEdgingWorkModel roadsEdgingWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated RoadsEdging Post API: ${Config.postApiUrlWaterTanker}');
      var roadsEdgingWorkModelData = roadsEdgingWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(roadsEdgingWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('RoadsEdging data posted successfully: $roadsEdgingWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting RoadsEdging data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllRoadEdging() async{
    var roadEdging = await roadsEdgingWorkRepository.getRoadsEdgingWork();
    allRoadEdging.value = roadEdging;

  }

  addRoadEdging(RoadsEdgingWorkModel roadsEdgingWorkModel){
    roadsEdgingWorkRepository.add(roadsEdgingWorkModel);

  }

  updateRoadEdging(RoadsEdgingWorkModel roadsEdgingWorkModel){
    roadsEdgingWorkRepository.update(roadsEdgingWorkModel);
    fetchAllRoadEdging();
  }

  deleteRoadEdging(int id){
    roadsEdgingWorkRepository.delete(id);
    fetchAllRoadEdging();
  }

}

