
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/first_floor_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/first_floor_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class FirstFloorViewModel extends GetxController {

  var allFirstFloor = <FirstFloorModel>[].obs;
  FirstFloorRepository firstFloorRepository = FirstFloorRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedFirstFloor = await firstFloorRepository.getUnPostedFirstFloorMosque();

      for (var firstFloor in unPostedFirstFloor) {
        try {
          // Step 2: Attempt to post the data to the API
          await postFirstFloorToAPI(firstFloor);

          // Step 3: If successful, update the posted status in the local database
          firstFloor.posted = 1;
          await firstFloorRepository.update(firstFloor);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('FirstFloor with id ${firstFloor.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post FirstFloor with id ${firstFloor.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted FirstFloor: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postFirstFloorToAPI(FirstFloorModel firstFloorModelModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated FirstFloor Post API: ${Config.postApiUrlFirstFloorMosque}');
      var firstFloorModelData = firstFloorModelModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlFirstFloorMosque),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(firstFloorModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('FirstFloor data posted successfully: $firstFloorModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting FirstFloor data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllFirstFloor() async{
    var firstFloor = await firstFloorRepository.getFirstFloor();
    allFirstFloor.value = firstFloor;

  }
  fetchAndSaveFirstFloorData() async {
    await firstFloorRepository.fetchAndSaveFirstFloorData();
  }
  addFirstFloor(FirstFloorModel firstFloorModel){
    firstFloorRepository.add(firstFloorModel);

  }

  updateFirstFloor(FirstFloorModel firstFloorModel){
    firstFloorRepository.update(firstFloorModel);
    fetchAllFirstFloor();
  }

  deleteFirstFloor(int id){
    firstFloorRepository.delete(id);
    fetchAllFirstFloor();
  }

}

