
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/brick_work_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/brick_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class BrickWorkViewModel extends GetxController {

  var allBrick = <BrickWorkModel>[].obs;
  BrickWorkRepository brickWorkRepository = BrickWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllBrick();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedBrickWork = await brickWorkRepository.getUnPostedBrickWork();

      for (var brickWork in unPostedBrickWork) {
        try {
          // Step 2: Attempt to post the data to the API
          await postBrickWorkToAPI(brickWork);

          // Step 3: If successful, update the posted status in the local database
          brickWork.posted = 1;
          await brickWorkRepository.update(brickWork);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('BrickWork with id ${brickWork.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post BrickWork with id ${brickWork.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted BrickWork: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postBrickWorkToAPI(BrickWorkModel brickWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated BrickWork Post API: ${Config.postApiUrlBrickWork}');
      var brickWorkModelData = brickWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlBrickWork),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(brickWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('BrickWork data posted successfully: $brickWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting BrickWork data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllBrick() async{
    var asphalts = await brickWorkRepository.getBrickWork();
    allBrick .value = asphalts;

  }

  addBrick(BrickWorkModel brickWorkModel){
    brickWorkRepository.add(brickWorkModel);
    //fetchAllBrick();
  }

  updateBrick(BrickWorkModel brickWorkModel){
    brickWorkRepository.update(brickWorkModel);
    fetchAllBrick();
  }

  deleteBrick(int id){
    brickWorkRepository.delete(id);
    fetchAllBrick();
  }

}

