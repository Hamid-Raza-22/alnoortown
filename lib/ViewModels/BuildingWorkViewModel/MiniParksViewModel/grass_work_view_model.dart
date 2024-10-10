import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/grass_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/grass_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class GrassWorkViewModel extends GetxController {
  var allGrass = <GrassWorkModel>[].obs;
  var filteredGrass = <GrassWorkModel>[].obs; // New observable for filtered data
  GrassWorkRepository grassWorkRepository = GrassWorkRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllGrass(); // Load data when initializing
  }

  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedGrassWork = await grassWorkRepository.getUnPostedGrassWorkMp();

      for (var grassWork in unPostedGrassWork) {
        try {
          // Step 2: Attempt to post the data to the API
          await postGrassWorkToAPI(grassWork);

          // Step 3: If successful, update the posted status in the local database
          grassWork.posted = 1;
          await grassWorkRepository.update(grassWork);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('grassWork with id ${grassWork.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post grassWork with id ${grassWork.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted grassWork: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postGrassWorkToAPI(GrassWorkModel grassWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      if (kDebugMode) {
        print('Updated grassWork Post API: ${Config.postApiUrlGrassWorkMiniPark}');
      }
      var grassWorkModelData = grassWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlGrassWorkMiniPark),         headers: {
        "Content-Type": "application/json",  // Set the request content type to JSON
        "Accept": "application/json",
      },
        body: jsonEncode(grassWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('grassWork data posted successfully: $grassWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting grassWork data: $e');
      throw Exception('Failed to post data: $e');
    }
  }
  fetchAllGrass() async {
    var grass = await grassWorkRepository.getGrassWork();
    allGrass.value = grass;
    filteredGrass.value = grass; // Initially, filtered data is the same as all data
  }

  // New method to filter grass work data
  void filterGrassWork(DateTime? fromDate, DateTime? toDate) {
    if (fromDate == null && toDate == null) {
      filteredGrass.value = allGrass; // Reset if no dates are provided
    } else {
      filteredGrass.value = allGrass.where((grass) {
        bool matchesFromDate = fromDate == null || grass.start_date!.isAfter(fromDate) || grass.start_date!.isAtSameMomentAs(fromDate);
        bool matchesToDate = toDate == null || grass.start_date!.isBefore(toDate) || grass.start_date!.isAtSameMomentAs(toDate);
        return matchesFromDate && matchesToDate;
      }).toList();
    }
  }
  fetchAndSaveGrassWorkData() async {
    await grassWorkRepository .fetchAndSaveGrassWorkData();
  }
  addGrass(GrassWorkModel grassWorkModel) {
    grassWorkRepository.add(grassWorkModel);
  }

  updateGrass(GrassWorkModel grassWorkModel) {
    grassWorkRepository.update(grassWorkModel);
    fetchAllGrass();
  }

  deleteGrass(int id) {
    grassWorkRepository.delete(id);
    fetchAllGrass();
  }
}


