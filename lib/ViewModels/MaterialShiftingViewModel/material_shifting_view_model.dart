
import 'package:al_noor_town/Models/MaterialShiftingModels/shifting_work_model.dart';
import 'package:al_noor_town/Repositories/MaterialShiftingRepositories/shifting_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
class MaterialShiftingViewModel extends GetxController {

  var allShifting = <ShiftingWorkModel>[].obs;
  ShiftingWorkRepository shiftingWorkRepository = ShiftingWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllShifting ();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMaterialShifting = await shiftingWorkRepository.getUnPostedShiftingWork();

      for (var materialShifting in unPostedMaterialShifting) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMaterialShiftingToAPI(materialShifting);

          // Step 3: If successful, update the posted status in the local database
          materialShifting.posted = 1;
          await shiftingWorkRepository.update(materialShifting);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MaterialShifting with id ${materialShifting.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MaterialShifting with id ${materialShifting.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MaterialShifting: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMaterialShiftingToAPI(ShiftingWorkModel shiftingWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MaterialShifting Post API: ${Config.waterTankerPostApi}');
      var shiftingWorkModelData = shiftingWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.waterTankerPostApi),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(shiftingWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MaterialShifting data posted successfully: $shiftingWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MaterialShifting data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllShifting() async{
    var shift = await shiftingWorkRepository.getShiftingWork();
    allShifting .value = shift;

  }

  addShift(ShiftingWorkModel shiftingWorkModel){
    shiftingWorkRepository.add(shiftingWorkModel);
    //fetchAllShifting();
  }

  updateShift(ShiftingWorkModel shiftingWorkModel){
    shiftingWorkRepository.update(shiftingWorkModel);
    fetchAllShifting();
  }

  deleteShift(int id){
    shiftingWorkRepository.delete(id);
    fetchAllShifting();
  }

}

