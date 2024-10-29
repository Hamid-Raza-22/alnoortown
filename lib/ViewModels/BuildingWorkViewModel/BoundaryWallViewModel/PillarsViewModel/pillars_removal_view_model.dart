import 'dart:convert';

import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../../../../Models/BuildingWorkModels/BoundarywallModel/PillarsModel/pillars_fixing_model.dart';
import '../../../../Models/BuildingWorkModels/BoundarywallModel/PillarsModel/pillars_removal_model.dart';
import '../../../../Repositories/BuildingWorkRepositories/BoundaryWallRepository/PillarsRepository/pillars_fixing_repository.dart';
import '../../../../Repositories/BuildingWorkRepositories/BoundaryWallRepository/PillarsRepository/pillars_removal_repository.dart';

class PillarsRemovalViewModel extends GetxController {

  var allPillarsRemoval = <PillarsRemovalModel>[].obs;
  PillarsRemovalRepository pillarsRemovalRepository = PillarsRemovalRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    // fetchAllBoundary();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPillarsRemoval = await pillarsRemovalRepository.getUnPostedPillarsRemoval();

      for (var pillarsRemoval in unPostedPillarsRemoval) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPillarsRemovalToAPI(pillarsRemoval);

          // Step 3: If successful, update the posted status in the local database
          pillarsRemoval.posted = 1;
          await pillarsRemovalRepository.update(pillarsRemoval);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('PillarsRemoval with id ${pillarsRemoval.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post PillarsRemoval with id ${pillarsRemoval.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted PillarsRemoval: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postPillarsRemovalToAPI(PillarsRemovalModel pillarsRemovalModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated PillarsFixing Post API: ${Config.postApiUrlPillarsRemoval}');
      var pillarsRemovalModelData = pillarsRemovalModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlPillarsRemoval),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(pillarsRemovalModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('PillarsRemoval data posted successfully: $pillarsRemovalModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting PillarsRemoval data: $e');
      throw Exception('Failed to post data: $e');
    }
  }
  void filterPillarsRemoval(DateTime? fromDate, DateTime? toDate, String? block) {
    allPillarsRemoval.value = allPillarsRemoval.where((roadCurb) {
      final date = DateTime.parse(roadCurb.date!);
      final isWithinDateRange = (fromDate == null || date.isAfter(fromDate)) &&
          (toDate == null || date.isBefore(toDate));
      final matchesBlock = block == null || roadCurb.block == block;

      return isWithinDateRange && matchesBlock;
    }).toList();
  }
  fetchAllPillarsRemoval() async{
    var pillarsRemoval = await pillarsRemovalRepository.getPillarsRemoval();
    allPillarsRemoval.value = pillarsRemoval;
  }
  fetchAndSavePillarsRemovalData() async {
    await pillarsRemovalRepository.fetchAndSavePillarsRemovalData();
  }
  addPillarsRemoval(PillarsRemovalModel pillarsRemovalModel){
    pillarsRemovalRepository.add(pillarsRemovalModel);

  }

  updatePillarsRemoval(PillarsRemovalModel pillarsRemovalModel){
    pillarsRemovalRepository.update(pillarsRemovalModel);
    fetchAllPillarsRemoval();
  }

  deletePillarsRemoval(int id){
    pillarsRemovalRepository.delete(id);
    fetchAllPillarsRemoval();
  }

}

