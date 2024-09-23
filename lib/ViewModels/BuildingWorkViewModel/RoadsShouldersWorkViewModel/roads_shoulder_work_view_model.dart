
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsShoulderWorkModel/roads_shoulder_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsShoulderWorkRepository/roads_shoulder_work_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';


class RoadsShoulderWorkViewModel extends GetxController {

  var allRoadShoulder = <RoadsShoulderWorkModel>[].obs;
  RoadsShoulderWorkRepository roadsShoulderWorkRepository = RoadsShoulderWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedRoadsShoulder = await roadsShoulderWorkRepository.getUnPostedRoadsShoulder();

      for (var roadsShoulder in unPostedRoadsShoulder) {
        try {
          // Step 2: Attempt to post the data to the API
          await postRoadsShoulderToAPI(roadsShoulder);

          // Step 3: If successful, update the posted status in the local database
          roadsShoulder.posted = 1;
          await roadsShoulderWorkRepository.update(roadsShoulder);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('RoadsShoulder with id ${roadsShoulder.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post RoadsShoulder with id ${roadsShoulder.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted RoadsShoulder: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postRoadsShoulderToAPI(RoadsShoulderWorkModel roadsShoulderWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated RoadsShoulder Post API: ${Config.postApiUrlRoadShoulder}');
      var roadsShoulderWorkModelData = roadsShoulderWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlRoadShoulder),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(roadsShoulderWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('RoadsShoulder data posted successfully: $roadsShoulderWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting RoadsShoulder data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllRoadShoulder() async{
    var roadsShoulder = await roadsShoulderWorkRepository.getRoadsShoulderWork();
    allRoadShoulder.value = roadsShoulder;

  }

  addRoadShoulder(RoadsShoulderWorkModel roadsShoulderWorkModel){
    roadsShoulderWorkRepository.add(roadsShoulderWorkModel);

  }

  updateRoadShoulder(RoadsShoulderWorkModel roadsShoulderWorkModel){
    roadsShoulderWorkRepository.update(roadsShoulderWorkModel);
    fetchAllRoadShoulder();
  }

  deleteRoadShoulder(int id){
    roadsShoulderWorkRepository.delete(id);
    fetchAllRoadShoulder();
  }

}

