
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
    // Your existing code for posting data
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


