import 'dart:convert';

import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


import '../../../../Models/BuildingWorkModels/BoundarywallModel/PlanksModel/planks_removal_model.dart';
import '../../../../Repositories/BuildingWorkRepositories/BoundaryWallRepository/PlanksRepository/planks_fixing_repository.dart';
import '../../../../Repositories/BuildingWorkRepositories/BoundaryWallRepository/PlanksRepository/planks_removal_repository.dart';

class PlanksRemovalViewModel extends GetxController {

  var allPlanksRemoval = <PlanksRemovalModel>[].obs;
  PlanksRemovalRepository planksRemovalRepository = PlanksRemovalRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    // fetchAllBoundary();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPlanksRemoval = await planksRemovalRepository.getUnPostedPlanksRemoval();

      for (var planksRemoval in unPostedPlanksRemoval) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPlanksRemovalToAPI(planksRemoval);

          // Step 3: If successful, update the posted status in the local database
          planksRemoval.posted = 1;
          await planksRemovalRepository.update(planksRemoval);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('PlanksRemoval with id ${planksRemoval.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post PlanksRemoval with id ${planksRemoval.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted PlanksRemoval: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postPlanksRemovalToAPI(PlanksRemovalModel planksRemovalModel) async {
    try {
      await Config.fetchLatestConfig();
      if (kDebugMode) {
        print('Updated PlanksRemoval Post API: ${Config.postApiUrlPlanksRemoval}');
      }
      var planksRemovalModelData = planksRemovalModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlPlanksRemoval),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(planksRemovalModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('PlanksRemoval data posted successfully: $planksRemovalModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting PlanksRemoval data: $e');
      throw Exception('Failed to post data: $e');
    }
  }
  void filterPlanksRemoval(DateTime? fromDate, DateTime? toDate, String? block) {
    allPlanksRemoval.value = allPlanksRemoval.where((roadCurb) {
      final date = DateTime.parse(roadCurb.date!);
      final isWithinDateRange = (fromDate == null || date.isAfter(fromDate)) &&
          (toDate == null || date.isBefore(toDate));
      final matchesBlock = block == null || roadCurb.block == block;

      return isWithinDateRange && matchesBlock;
    }).toList();
  }
  fetchAllPlanksRemoval() async{
    var planksRemoval = await planksRemovalRepository.getPlanksRemoval();
    allPlanksRemoval.value = planksRemoval;
  }
  fetchAndSavePlanksRemovalData() async {
    await planksRemovalRepository.fetchAndSavePlanksRemovalData();
  }
  addPillarsFixing(PlanksRemovalModel planksRemovalModel){
    planksRemovalRepository.add(planksRemovalModel);

  }

  updatePlanksFixing(PlanksRemovalModel planksRemovalModel){
    planksRemovalRepository.update(planksRemovalModel);
    fetchAllPlanksRemoval();
  }

  deletePlanksFixing(int id){
    planksRemovalRepository.delete(id);
    fetchAllPlanksRemoval();
  }

}

