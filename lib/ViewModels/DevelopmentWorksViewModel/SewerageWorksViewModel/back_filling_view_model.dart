
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/back_filing_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/SewerageWorksRepositries/back_filling_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class BackFillingViewModel extends GetxController {

  var allFill = <BackFilingModel>[].obs;
  BackFillingRepository backFillingRepository = BackFillingRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllFill ();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedBackFilling = await backFillingRepository.getUnPostedBackFilling();

      for (var backFilling in unPostedBackFilling) {
        try {
          // Step 2: Attempt to post the data to the API
          await postBackFillingToAPI(backFilling);

          // Step 3: If successful, update the posted status in the local database
          backFilling.posted = 1;
          await backFillingRepository.update(backFilling);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('BackFilling with id ${backFilling.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post WaterTanker with id ${backFilling.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted BackFilling: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postBackFillingToAPI(BackFilingModel backFilingModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated BackFilling Post API: ${Config.waterTankerPostApi}');
      var backFilingModelData = backFilingModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.waterTankerPostApi),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(backFilingModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('BackFilling data posted successfully: $backFilingModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting BackFilling data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllFill() async{
    var filling = await backFillingRepository.getFiling();
    allFill .value = filling;

  }

  addFill(BackFilingModel filingModel){
    backFillingRepository.add(filingModel);
    //fetchAllFill();
  }

  updateFill(BackFilingModel filingModel){
    backFillingRepository.update(filingModel);
    fetchAllFill();
  }

  deleteFill(int id){
    backFillingRepository.delete(id);
    fetchAllFill();
  }

}

