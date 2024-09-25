import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/iron_works_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/iron_works_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class IronWorkViewModel extends GetxController {
  var allWorks = <IronWorksModel>[].obs;
  final IronWorksRepository ironWorksRepository = IronWorksRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllWorks(); // Initial fetch if needed
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedIronWorks = await ironWorksRepository.getUnPostedIronWorks();

      for (var ironWorks in unPostedIronWorks) {
        try {
          // Step 2: Attempt to post the data to the API
          await postWaterTankerToAPI(ironWorks);

          // Step 3: If successful, update the posted status in the local database
          ironWorks.posted = 1;
          await ironWorksRepository.update(ironWorks);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('WaterTanker with id ${ironWorks.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post WaterTanker with id ${ironWorks.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted WaterTanker: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postWaterTankerToAPI(IronWorksModel ironWorksModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated ironWorks Post API: ${Config.postApiUrlIronWork}');
      var ironWorksModelData = ironWorksModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlIronWork),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(ironWorksModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('ironWorks data posted successfully: $ironWorksModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting ironWorks data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  Future<void> fetchAllWorks({DateTime? fromDate, DateTime? toDate, String? block}) async {
    // Fetch all works from repository
    var allWorksList = await ironWorksRepository.getIronWorks();

    // Apply filters if provided
    if (fromDate != null) {
      allWorksList = allWorksList.where((work) => work.date != null && DateTime.parse(work.date!).isAfter(fromDate)).toList();
    }
    if (toDate != null) {
      allWorksList = allWorksList.where((work) => work.date != null && DateTime.parse(work.date!).isBefore(toDate)).toList();
    }
    if (block != null && block.isNotEmpty) {
      allWorksList = allWorksList.where((work) => work.block_no != null && work.block_no!.contains(block)).toList();
    }

    // Update the observable list
    allWorks.value = allWorksList;
  }


  fetchAndSaveIronWorksData() async {
    await ironWorksRepository.fetchAndSaveIronsWorksData();
  }


  Future<void> addWorks(IronWorksModel ironWorksModel) async {
    await ironWorksRepository.add(ironWorksModel);
    fetchAllWorks(); // Optionally refresh after adding
  }

  void updateWorks(IronWorksModel ironWorksModel) {
    ironWorksRepository.update(ironWorksModel);
    fetchAllWorks(); // Refresh after updating
  }

  void deleteWorks(int id) {
    ironWorksRepository.delete(id);
    fetchAllWorks(); // Refresh after deleting
  }
}
