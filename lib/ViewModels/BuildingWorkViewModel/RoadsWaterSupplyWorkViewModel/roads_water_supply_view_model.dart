import 'package:al_noor_town/Models/BuildingWorkModels/RoadsWaterSupplyWorkModel/roads_water_supply_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsWaterSupplyWorkRepository/roads_water_supply_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class RoadsWaterSupplyViewModel extends GetxController {

  var allRoadWaterSupply = <RoadsWaterSupplyModel>[].obs;
  var filteredRoadWaterSupply = <RoadsWaterSupplyModel>[].obs;  // New observable for filtered data
  RoadsWaterSupplyRepository roadsWaterSupplyRepository = RoadsWaterSupplyRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllRoadWaterSupply();
  }

  Future<void> postDataFromDatabaseToAPI() async {
    try {
      var unPostedRoadsWaterSupplyWork = await roadsWaterSupplyRepository.getUnPostedRoadsWaterSupplyWork();

      for (var roadsWaterSupplyWork in unPostedRoadsWaterSupplyWork) {
        try {
          await postRoadsWaterSupplyWorkToAPI(roadsWaterSupplyWork);
          roadsWaterSupplyWork.posted = 1;
          await roadsWaterSupplyRepository.update(roadsWaterSupplyWork);

          if (kDebugMode) {
            print('RoadsWaterSupplyWork with id ${roadsWaterSupplyWork.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post RoadsWaterSupplyWork with id ${roadsWaterSupplyWork.id}: $e');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted RoadsWaterSupplyWork: $e');
      }
    }
  }

  Future<void> postRoadsWaterSupplyWorkToAPI(RoadsWaterSupplyModel roadsWaterSupplyModel) async {
    try {
      await Config.fetchLatestConfig();
      var roadsWaterSupplyModelData = roadsWaterSupplyModel.toMap();
      final response = await http.post(
        Uri.parse(Config.postApiUrlRoadsWaterSupplyWork),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(roadsWaterSupplyModelData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('RoadsWaterSupplyWork data posted successfully: $roadsWaterSupplyModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting RoadsWaterSupplyWork data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  // Fetch all road water supply data
  fetchAllRoadWaterSupply() async {
    var roadsWaterSupply = await roadsWaterSupplyRepository.getRoadsWaterSupply();
    allRoadWaterSupply.value = roadsWaterSupply;
    filteredRoadWaterSupply.value = roadsWaterSupply;  // Initially show all data
  }

  fetchAndSaveRoadsWaterSupplyData() async {
    await roadsWaterSupplyRepository.fetchAndSaveRoadsWaterSupplyData();
  }

  addRoadsWaterSupply(RoadsWaterSupplyModel roadsWaterSupplyModel) {
    roadsWaterSupplyRepository.add(roadsWaterSupplyModel);
    fetchAllRoadWaterSupply();
  }

  updateRoadsWaterSupply(RoadsWaterSupplyModel roadsWaterSupplyModel) {
    roadsWaterSupplyRepository.update(roadsWaterSupplyModel);
    fetchAllRoadWaterSupply();
  }

  deleteRoadsWaterSupply(int id) {
    roadsWaterSupplyRepository.delete(id);
    fetchAllRoadWaterSupply();
  }

  // New method for filtering data based on date and block
  void filterData(DateTime? fromDate, DateTime? toDate, String? block) {
    List<RoadsWaterSupplyModel> filteredList = allRoadWaterSupply.where((entry) {
      bool matchesDateRange = true;
      bool matchesBlock = true;

      if (fromDate != null && toDate != null) {
        matchesDateRange = entry.start_date != null &&
            entry.start_date!.isAfter(fromDate) &&
            entry.start_date!.isBefore(toDate);
      }

      if (block != null && block.isNotEmpty) {
        matchesBlock = entry.block_no != null &&
            entry.block_no!.toLowerCase().contains(block.toLowerCase());
      }

      return matchesDateRange && matchesBlock;
    }).toList();

    filteredRoadWaterSupply.value = filteredList;
  }
}
