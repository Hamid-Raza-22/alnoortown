
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/base_sub_base_compaction_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsCompactionWorkRepository/base_sub_base_compaction_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
class BaseSubBaseCompactionViewModel extends GetxController {

  var allSubBase = <BaseSubBaseCompactionModel>[].obs;
  BaseSubBaseCompactionRepository baseSubBaseCompactionRepository = BaseSubBaseCompactionRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedBaseSubBaseCompaction = await baseSubBaseCompactionRepository.getUnPostedBaseSubBase();

      for (var baseSubBase in unPostedBaseSubBaseCompaction) {
        try {
          // Step 2: Attempt to post the data to the API
          await postBaseSubBaseCompactionToAPI(baseSubBase);

          // Step 3: If successful, update the posted status in the local database
          baseSubBase.posted = 1;
          await baseSubBaseCompactionRepository.update(baseSubBase);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('BaseSubBaseCompaction with id ${baseSubBase.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post BaseSubBaseCompaction with id ${baseSubBase.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted BaseSubBaseCompaction: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postBaseSubBaseCompactionToAPI(BaseSubBaseCompactionModel baseSubBaseCompactionModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated BaseSubBaseCompaction Post API: ${Config.postApiUrlBaseSubBaseCompaction}');
      var baseSubBaseCompactionModelData = baseSubBaseCompactionModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlBaseSubBaseCompaction),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(baseSubBaseCompactionModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('BaseSubBaseCompaction data posted successfully: $baseSubBaseCompactionModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting BaseSubBaseCompaction data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllSubBase() async{
    var subBase = await baseSubBaseCompactionRepository.getSubBaseCompaction();
    allSubBase.value = subBase;

  }
  fetchAndSaveBaseSubBaseCompactionData() async {
    await baseSubBaseCompactionRepository.fetchAndSaveBaseSubBaseCompactionData();
  }
  addSubBase(BaseSubBaseCompactionModel baseSubBaseCompactionModel){
    baseSubBaseCompactionRepository.add(baseSubBaseCompactionModel);

  }

  updateSubBase(BaseSubBaseCompactionModel baseSubBaseCompactionModel){
    baseSubBaseCompactionRepository.update(baseSubBaseCompactionModel);
    fetchAllSubBase();
  }

  deleteSubBase(int id){
    baseSubBaseCompactionRepository.delete(id);
    fetchAllSubBase();
  }

}

