
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsWaterSupplyWorkModel/back_filling_ws_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsWaterSupplyWorkRepository/back_filling_ws_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class BackFillingWsViewModel extends GetxController {

  var allWsBackFilling = <BackFillingWsModel>[].obs;
  BackFillingWsRepository backFillingWsRepository = BackFillingWsRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedBackFillingWaterSupply = await backFillingWsRepository.getUnPostedWaterSupplyBackFilling();

      for (var backFillingWaterSupply in unPostedBackFillingWaterSupply) {
        try {
          // Step 2: Attempt to post the data to the API
          await postBackFillingWaterSupplyToAPI(backFillingWaterSupply);

          // Step 3: If successful, update the posted status in the local database
          backFillingWaterSupply.posted = 1;
          await backFillingWsRepository.update(backFillingWaterSupply);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('BackFillingWaterSupply with id ${backFillingWaterSupply.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post BackFillingWaterSupply with id ${backFillingWaterSupply.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted BackFillingWaterSupply: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postBackFillingWaterSupplyToAPI(BackFillingWsModel backFillingWsModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated BackFillingWaterSupply Post API: ${Config.postApiUrlWaterTanker}');
      var backFillingWsModelData = backFillingWsModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(backFillingWsModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('BackFillingWaterSupply data posted successfully: $backFillingWsModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting BackFillingWaterSupply data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllWsBackFilling() async{
    var wsBackFilling = await backFillingWsRepository.getBackFillingWs();
    allWsBackFilling.value = wsBackFilling;

  }

  addWsBackFilling(BackFillingWsModel backFillingWsModel){
    backFillingWsRepository.add(backFillingWsModel);

  }

  updateWsBackFilling(BackFillingWsModel backFillingWsModel){
    backFillingWsRepository.update(backFillingWsModel);
    fetchAllWsBackFilling();
  }

  deleteWsBackFilling(int id){
    backFillingWsRepository.delete(id);
    fetchAllWsBackFilling();
  }

}

