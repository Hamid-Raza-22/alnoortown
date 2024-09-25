
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/mg_grey_structure_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/TownMainGatesRepository/mg_grey_structure_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
class MgGreyStructureViewModel extends GetxController {

  var allMainGrey = <MgGreyStructureModel>[].obs;
  MgGreyStructureRepository mgGreyStructureRepository = MgGreyStructureRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMainGateGreyStructure = await mgGreyStructureRepository.getUnPostedGreyStructure();

      for (var mainGateGreyStructure in unPostedMainGateGreyStructure) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMainGateGreyStructureToAPI(mainGateGreyStructure);

          // Step 3: If successful, update the posted status in the local database
          mainGateGreyStructure.posted = 1;
          await mgGreyStructureRepository.update(mainGateGreyStructure);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MainGateGreyStructure with id ${mainGateGreyStructure.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MainGateGreyStructure with id ${mainGateGreyStructure.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MainGateGreyStructure: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMainGateGreyStructureToAPI(MgGreyStructureModel mgGreyStructureModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MainGateGreyStructure Post API: ${Config.postApiUrlGreyStructureMainGate}');
      var mgGreyStructureModelData = mgGreyStructureModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlGreyStructureMainGate),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(mgGreyStructureModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MainGateGreyStructure data posted successfully: $mgGreyStructureModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MainGateGreyStructure data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllMainGrey() async{
    var mainGrey = await mgGreyStructureRepository.getMgGreyStructure();
    allMainGrey.value = mainGrey;

  }
  fetchAndSaveMainGateGreyStructureData() async {
    await mgGreyStructureRepository.fetchAndSaveMainGateGreyStructureData();
  }
  addMainGrey(MgGreyStructureModel mgGreyStructureModel){
    mgGreyStructureRepository.add(mgGreyStructureModel);

  }

  updateMainGrey(MgGreyStructureModel mgGreyStructureModel){
    mgGreyStructureRepository.update(mgGreyStructureModel);
    fetchAllMainGrey();
  }

  deleteMainGrey(int id){
    mgGreyStructureRepository.delete(id);
    fetchAllMainGrey();
  }

}

