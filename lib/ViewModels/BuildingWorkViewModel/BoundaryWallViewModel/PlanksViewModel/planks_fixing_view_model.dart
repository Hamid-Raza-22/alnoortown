import 'dart:convert';

import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../../../../Models/BuildingWorkModels/BoundarywallModel/PillarsModel/pillars_fixing_model.dart';
import '../../../../Models/BuildingWorkModels/BoundarywallModel/PlanksModel/planks_fixing_model.dart';
import '../../../../Repositories/BuildingWorkRepositories/BoundaryWallRepository/PillarsRepository/pillars_fixing_repository.dart';
import '../../../../Repositories/BuildingWorkRepositories/BoundaryWallRepository/PlanksRepository/planks_fixing_repository.dart';

class PlanksFixingViewModel extends GetxController {

  var allPlanksFixing = <PlanksFixingModel>[].obs;
  PlanksFixingRepository planksFixingRepository = PlanksFixingRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    // fetchAllBoundary();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPlanksFixing = await planksFixingRepository.getUnPostedPlanksFixing();

      for (var planksFixing in unPostedPlanksFixing) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPlanksFixingToAPI(planksFixing);

          // Step 3: If successful, update the posted status in the local database
          planksFixing.posted = 1;
          await planksFixingRepository.update(planksFixing);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('PlanksFixing with id ${planksFixing.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post PlanksFixing with id ${planksFixing.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted PlanksFixing: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postPlanksFixingToAPI(PlanksFixingModel planksFixingModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated PlanksFixing Post API: ${Config.postApiUrlPlanksFixing}');
      var planksFixingModelData = planksFixingModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlPlanksFixing),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(planksFixingModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('PlanksFixing data posted successfully: $planksFixingModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting PlanksFixing data: $e');
      throw Exception('Failed to post data: $e');
    }
  }
  void filterPlanksFixing(DateTime? fromDate, DateTime? toDate, String? block) {
    allPlanksFixing.value = allPlanksFixing.where((roadCurb) {
      final date = DateTime.parse(roadCurb.date!);
      final isWithinDateRange = (fromDate == null || date.isAfter(fromDate)) &&
          (toDate == null || date.isBefore(toDate));
      final matchesBlock = block == null || roadCurb.block == block;

      return isWithinDateRange && matchesBlock;
    }).toList();
  }
  fetchAllPlanksFixing() async{
    var planksFixing = await planksFixingRepository.getPlanksFixing();
    allPlanksFixing.value = planksFixing;
  }
  fetchAndSavePlanksFixingData() async {
    await planksFixingRepository.fetchAndSavePlanksFixingData();
  }
  addPillarsFixing(PlanksFixingModel planksFixingModel){
    planksFixingRepository.add(planksFixingModel);

  }

  updatePlanksFixing(PlanksFixingModel planksFixingModel){
    planksFixingRepository.update(planksFixingModel);
    fetchAllPlanksFixing();
  }

  deletePlanksFixing(int id){
    planksFixingRepository.delete(id);
    fetchAllPlanksFixing();
  }

}

