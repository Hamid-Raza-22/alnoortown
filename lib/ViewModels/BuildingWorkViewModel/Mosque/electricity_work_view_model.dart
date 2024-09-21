
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/electricity_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/electricity_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class ElectricityWorkViewModel extends GetxController {

  var allElectricity = <ElectricityWorkModel>[].obs;
  ElectricityWorkRepository electricityWorkRepository = ElectricityWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedElectricity = await electricityWorkRepository.getUnPostedElectricityWork();

      for (var electricity in unPostedElectricity) {
        try {
          // Step 2: Attempt to post the data to the API
          await postElectricityWorksToAPI(electricity);

          // Step 3: If successful, update the posted status in the local database
          electricity.posted = 1;
          await electricityWorkRepository.update(electricity);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('Electricity with id ${electricity.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post Electricity with id ${electricity.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted Electricity: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postElectricityWorksToAPI(ElectricityWorkModel electricityWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated Electricity Post API: ${Config.postApiUrlWaterTanker}');
      var electricityWorkModelData = electricityWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(electricityWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Electricity data posted successfully: $electricityWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting Electricity data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllElectricity() async{
    var electricity = await electricityWorkRepository.getElectricityWork();
    allElectricity.value = electricity;

  }

  addElectricity(ElectricityWorkModel electricityWorkModel){
    electricityWorkRepository.add(electricityWorkModel);

  }

  updateElectricity(ElectricityWorkModel electricityWorkModel){
    electricityWorkRepository.update(electricityWorkModel);
    fetchAllElectricity();
  }

  deleteElectricity(int id){
    electricityWorkRepository.delete(id);
    fetchAllElectricity();
  }

}

