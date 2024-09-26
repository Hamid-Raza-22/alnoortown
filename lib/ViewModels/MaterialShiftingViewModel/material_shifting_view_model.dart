import 'package:al_noor_town/Models/MaterialShiftingModels/shifting_work_model.dart';
import 'package:al_noor_town/Repositories/MaterialShiftingRepositories/shifting_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class MaterialShiftingViewModel extends GetxController {
  var allShifting = <ShiftingWorkModel>[].obs;
  var filteredShifting = <ShiftingWorkModel>[].obs; // For filtered results
  ShiftingWorkRepository shiftingWorkRepository = ShiftingWorkRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllShifting();
  }

  Future<void> postDataFromDatabaseToAPI() async {
    try {
      var unPostedMaterialShifting = await shiftingWorkRepository.getUnPostedShiftingWork();

      for (var materialShifting in unPostedMaterialShifting) {
        try {
          await postMaterialShiftingToAPI(materialShifting);

          materialShifting.posted = 1;
          await shiftingWorkRepository.update(materialShifting);

          if (kDebugMode) {
            print('MaterialShifting with id ${materialShifting.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MaterialShifting with id ${materialShifting.id}: $e');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MaterialShifting: $e');
      }
    }
  }

  Future<void> postMaterialShiftingToAPI(ShiftingWorkModel shiftingWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MaterialShifting Post API: ${Config.postApiUrlShiftingWork}');
      var shiftingWorkModelData = shiftingWorkModel.toMap();
      final response = await http.post(
        Uri.parse(Config.postApiUrlShiftingWork),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(shiftingWorkModelData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MaterialShifting data posted successfully: $shiftingWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MaterialShifting data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  Future<void> fetchAllShifting() async {
    var shift = await shiftingWorkRepository.getShiftingWork();
    allShifting.value = shift;
    filteredShifting.value = shift; // Initially, both lists are the same
  }

  Future<void> fetchAndSaveMaterialShiftingData() async {
    await shiftingWorkRepository.fetchAndSaveShiftingWorkData();
  }

  void addShift(ShiftingWorkModel shiftingWorkModel) {
    shiftingWorkRepository.add(shiftingWorkModel);
  }

  void updateShift(ShiftingWorkModel shiftingWorkModel) {
    shiftingWorkRepository.update(shiftingWorkModel);
    fetchAllShifting();
  }

  void deleteShift(int id) {
    shiftingWorkRepository.delete(id);
    fetchAllShifting();
  }

  // New method to filter data
  void filterData(DateTime? fromDate, DateTime? toDate, String? block) {
    filteredShifting.clear();

    // Filter logic
    filteredShifting.addAll(allShifting.where((entry) {
      bool matchesDate = true;
      if (fromDate != null) {
        matchesDate = matchesDate && entry.date!.isAfter(fromDate.subtract(Duration(days: 1)));
      }
      if (toDate != null) {
        matchesDate = matchesDate && entry.date!.isBefore(toDate.add(Duration(days: 1)));
      }

      bool matchesBlock = block == null ||
          entry.from_block!.contains(block) ||
          entry.to_block!.contains(block);

      return matchesDate && matchesBlock;
    }));
  }
}
