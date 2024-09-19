
import 'dart:convert';

import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/cubstones_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/cubstones_work_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class CubStonesWorkViewModel extends GetxController {

  var allCubStones = <CubStonesWorkModel>[].obs;
  CubStonesWorkRepository cubStonesWorkRepository = CubStonesWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedCurbStone = await cubStonesWorkRepository.getUnPostedCubStonesWork();

      for (var curbStone in unPostedCurbStone) {
        try {
          // Step 2: Attempt to post the data to the API
          await postCurbStoneToAPI(curbStone);

          // Step 3: If successful, update the posted status in the local database
          curbStone.posted = 1;
          await cubStonesWorkRepository.update(curbStone);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('CurbStone with id ${curbStone.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post CurbStone with id ${curbStone.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted CurbStone: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postCurbStoneToAPI(CubStonesWorkModel cubStonesWorkModel) async {
    try {
      var cubStonesWorkModelData = cubStonesWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse('http://103.149.32.30:8080/ords/alnoor_town/watertanker/post/'),  // Ensure this is the correct URL
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(cubStonesWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('CurbStone data posted successfully: $cubStonesWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting CurbStone data: $e');
      throw Exception('Failed to post data: $e');
    }
  }
  fetchAllCubStones() async{
    var cubStones = await cubStonesWorkRepository.getCubStonesWork();
    allCubStones.value = cubStones;

  }

  addCubStones(CubStonesWorkModel cubStonesWorkModel){
    cubStonesWorkRepository.add(cubStonesWorkModel);

  }

  updateCubStones(CubStonesWorkModel cubStonesWorkModel){
    cubStonesWorkRepository.update(cubStonesWorkModel);
    fetchAllCubStones();
  }

  deleteCubStones(int id){
    cubStonesWorkRepository.delete(id);
    fetchAllCubStones();
  }

}

