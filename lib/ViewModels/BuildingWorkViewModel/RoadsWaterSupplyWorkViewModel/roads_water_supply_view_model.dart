
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsWaterSupplyWorkModel/roads_water_supply_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsWaterSupplyWorkRepository/roads_water_supply_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class RoadsWaterSupplyViewModel extends GetxController {

  var allRoadWaterSupply = <RoadsWaterSupplyModel>[].obs;
  RoadsWaterSupplyRepository roadsWaterSupplyRepository = RoadsWaterSupplyRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedRoadsWaterSupplyWork = await roadsWaterSupplyRepository.getUnPostedRoadsWaterSupplyWork();

      for (var roadsWaterSupplyWork  in unPostedRoadsWaterSupplyWork) {
        try {
          // Step 2: Attempt to post the data to the API
          await postRoadsWaterSupplyWorkToAPI(roadsWaterSupplyWork);

          // Step 3: If successful, update the posted status in the local database
          roadsWaterSupplyWork.posted = 1;
          await roadsWaterSupplyRepository.update(roadsWaterSupplyWork);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('RoadsWaterSupplyWork with id ${roadsWaterSupplyWork.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post RoadsWaterSupplyWork with id ${roadsWaterSupplyWork.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted RoadsWaterSupplyWork: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postRoadsWaterSupplyWorkToAPI(RoadsWaterSupplyModel roadsWaterSupplyModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated RoadsWaterSupplyWork Post API: ${Config.postApiUrlRoadsWaterSupplyWork}');
      var roadsWaterSupplyModelData = roadsWaterSupplyModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlRoadsWaterSupplyWork),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(roadsWaterSupplyModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('RoadsWaterSupplyWork data posted successfully: $roadsWaterSupplyModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting RoadsWaterSupplyWork data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllRoadWaterSupply() async{
    var roadsWaterSupply = await roadsWaterSupplyRepository.getRoadsWaterSupply();
    allRoadWaterSupply.value = roadsWaterSupply;

  }
  fetchAndSaveRoadsWaterSupplyData() async {
    await roadsWaterSupplyRepository.fetchAndSaveRoadsWaterSupplyData();
  }

  addRoadsWaterSupply(RoadsWaterSupplyModel roadsWaterSupplyModel){
    roadsWaterSupplyRepository.add(roadsWaterSupplyModel);

  }

  updateRoadsWaterSupply(RoadsWaterSupplyModel roadsWaterSupplyModel){
    roadsWaterSupplyRepository.update(roadsWaterSupplyModel);
    fetchAllRoadWaterSupply();
  }

  deleteRoadsWaterSupply(int id){
    roadsWaterSupplyRepository.delete(id);
    fetchAllRoadWaterSupply();
  }

}

