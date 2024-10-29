import 'dart:convert';

import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../../../../Models/BuildingWorkModels/BoundarywallModel/PillarsModel/pillars_fixing_model.dart';
import '../../../../Repositories/BuildingWorkRepositories/BoundaryWallRepository/PillarsRepository/pillars_fixing_repository.dart';

class PillarsFixingViewModel extends GetxController {

  var allPillarsFixing = <PillarsFixingModel>[].obs;
  PillarsFixingRepository pillarsFixingRepository = PillarsFixingRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    // fetchAllBoundary();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPillarsFixing = await pillarsFixingRepository.getUnPostedPillarsFixing();

      for (var pillarsFixing in unPostedPillarsFixing) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPillarsFixingToAPI(pillarsFixing);

          // Step 3: If successful, update the posted status in the local database
          pillarsFixing.posted = 1;
          await pillarsFixingRepository.update(pillarsFixing);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('PillarsFixing with id ${pillarsFixing.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post PillarsFixing with id ${pillarsFixing.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted PillarsFixing: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postPillarsFixingToAPI(PillarsFixingModel pillarsFixingModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated PillarsFixing Post API: ${Config.postApiUrlPillarsFixing}');
      var pillarsFixingModelData = pillarsFixingModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlPillarsFixing),
        headers: {
        "Content-Type": "application/json",  // Set the request content type to JSON
        "Accept": "application/json",
      },
        body: jsonEncode(pillarsFixingModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('PillarsFixing data posted successfully: $pillarsFixingModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting PillarsFixing data: $e');
      throw Exception('Failed to post data: $e');
    }
  }
  void filterPillarFixing(DateTime? fromDate, DateTime? toDate, String? block) {
    allPillarsFixing.value = allPillarsFixing.where((roadCurb) {
      final date = DateTime.parse(roadCurb.date!);
      final isWithinDateRange = (fromDate == null || date.isAfter(fromDate)) &&
          (toDate == null || date.isBefore(toDate));
      final matchesBlock = block == null || roadCurb.block == block;

      return isWithinDateRange && matchesBlock;
    }).toList();
  }

  fetchAllPillarsFixing() async{
    var pillarsFixing = await pillarsFixingRepository.getPillarsFixing();
    allPillarsFixing.value = pillarsFixing;
  }
  fetchAndSavePillarsFixingData() async {
    await pillarsFixingRepository.fetchAndSavePillarsFixingData();
  }
  addPillarsFixing(PillarsFixingModel pillarsFixingModel){
    pillarsFixingRepository.add(pillarsFixingModel);

  }

  updatePillarsFixing(PillarsFixingModel pillarsFixingModel){
    pillarsFixingRepository.update(pillarsFixingModel);
    fetchAllPillarsFixing();
  }

  deletePillarsFixing(int id){
    pillarsFixingRepository.delete(id);
    fetchAllPillarsFixing();
  }

}

