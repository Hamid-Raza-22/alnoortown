import 'dart:convert';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/sitting_area_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/sitting_area_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class SittingAreaWorkViewModel extends GetxController {
  var allSitting = <SittingAreaWorkModel>[].obs;
  var filteredSitting = <SittingAreaWorkModel>[].obs;
  SittingAreaWorkRepository sittingAreaWorkRepository = SittingAreaWorkRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllSitting(); // Fetch data on initialization
  }

  Future<void> postDataFromDatabaseToAPI() async {
    try {
      var unPostedSittingArea = await sittingAreaWorkRepository.getUnPostedSittingArea();

      for (var sittingArea in unPostedSittingArea) {
        try {
          await postSittingAreaWorkToAPI(sittingArea);
          sittingArea.posted = 1;
          await sittingAreaWorkRepository.update(sittingArea);

          if (kDebugMode) {
            print('SittingArea with id ${sittingArea.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post SittingArea with id ${sittingArea.id}: $e');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted SittingArea: $e');
      }
    }
  }

  Future<void> postSittingAreaWorkToAPI(SittingAreaWorkModel sittingAreaWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated SittingArea Post API: ${Config.postApiUrlSittingAreaWork}');
      var sittingAreaWorkModelData = sittingAreaWorkModel.toMap();
      final response = await http.post(
        Uri.parse(Config.postApiUrlSittingAreaWork),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(sittingAreaWorkModelData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('SittingArea data posted successfully: $sittingAreaWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting SittingArea data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  Future<void> fetchAllSitting() async {
    var sitting = await sittingAreaWorkRepository.getSittingAreaWork();
    allSitting.value = sitting;
    filteredSitting.value = sitting; // Initialize filtered list with all data
  }

  Future<void> fetchAndSaveSittingAreaData() async {
    await sittingAreaWorkRepository.fetchAndSaveSittingAreaData();
  }

  void addSitting(SittingAreaWorkModel sittingAreaWorkModel) {
    sittingAreaWorkRepository.add(sittingAreaWorkModel);
  }

  void updateSitting(SittingAreaWorkModel sittingAreaWorkModel) {
    sittingAreaWorkRepository.update(sittingAreaWorkModel);
    fetchAllSitting();
  }

  void deleteSitting(int id) {
    sittingAreaWorkRepository.delete(id);
    fetchAllSitting();
  }

  // New method to apply filters
  void applyFilters(DateTime? fromDate, DateTime? toDate, String? block) {
    filteredSitting.value = allSitting.where((entry) {
      final entryDate = entry.start_date; // Adjust as needed
      final isDateInRange = (fromDate == null || (entryDate != null && entryDate.isAfter(fromDate))) &&
          (toDate == null || (entryDate != null && entryDate.isBefore(toDate)));
      final isBlockMatch = block == null || (entry.block != null && entry.block!.contains(block));
      return isDateInRange && isBlockMatch;
    }).toList();
  }
}
