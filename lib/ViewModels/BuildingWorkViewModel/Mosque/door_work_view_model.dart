
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/doors_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/door_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class DoorWorkViewModel extends GetxController {

  var allDoor = <DoorsWorkModel>[].obs;
  DoorWorkRepository doorWorkRepository = DoorWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedDoors = await doorWorkRepository.getUnPostedDoorsWork();

      for (var doorsWorks in unPostedDoors) {
        try {
          // Step 2: Attempt to post the data to the API
          await postDoorsWorksToAPI(doorsWorks);

          // Step 3: If successful, update the posted status in the local database
          doorsWorks.posted = 1;
          await doorWorkRepository.update(doorsWorks);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('DoorsWorks with id ${doorsWorks.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post DoorsWorks with id ${doorsWorks.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted DoorsWorks: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postDoorsWorksToAPI(DoorsWorkModel doorsWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('UpdatedDoorsWorks Post API: ${Config.waterTankerPostApi}');
      var doorsWorkModelData = doorsWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.waterTankerPostApi),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(doorsWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('DoorsWorks data posted successfully: $doorsWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting DoorsWorks data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllDoor() async{
    var door = await doorWorkRepository.getDoorWork();
    allDoor.value = door;

  }

  addDoor(DoorsWorkModel doorsWorkModel){
    doorWorkRepository.add(doorsWorkModel);

  }

  updateDoor(DoorsWorkModel doorsWorkModel){
    doorWorkRepository.update(doorsWorkModel);
    fetchAllDoor();
  }

  deleteDoor(int id){
    doorWorkRepository.delete(id);
    fetchAllDoor();
  }

}

