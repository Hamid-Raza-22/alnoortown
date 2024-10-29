import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCurbstonesWorkModel/road_curb_stones_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsCurbStonesWorkRepuository/road_curb_stones_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class RoadCurbStonesWorkViewModel extends GetxController {
  var allRoadCurb = <RoadCurbStonesWorkModel>[].obs;
  // var filteredRoadCurb = <RoadCurbStonesWorkModel>[].obs;
  RoadCurbStonesWorkRepository roadCurbStonesWorkRepository = RoadCurbStonesWorkRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllRoadCurb();
  }

  Future<void> fetchAllRoadCurb() async {
    var roadCurb = await roadCurbStonesWorkRepository.getRoadCurbStonesWork();
    allRoadCurb.value = roadCurb;

  }

  void filterRoadCurb(DateTime? fromDate, DateTime? toDate, String? block) {
    allRoadCurb.value = allRoadCurb.where((roadCurb) {
      final date = DateTime.parse(roadCurb.date!);
      final isWithinDateRange = (fromDate == null || date.isAfter(fromDate)) &&
          (toDate == null || date.isBefore(toDate));
      final matchesBlock = block == null || roadCurb.block_no == block;

      return isWithinDateRange && matchesBlock;
    }).toList();
  }

  Future<void> postDataFromDatabaseToAPI() async {
    try {
      var unPostedRoadCurbStone = await roadCurbStonesWorkRepository.getUnPostedRoadCurbStones();

      for (var roadCurbStone in unPostedRoadCurbStone) {
        try {
          await postRoadCurbStoneToAPI(roadCurbStone);
          roadCurbStone.posted = 1;
          await roadCurbStonesWorkRepository.update(roadCurbStone);

          if (kDebugMode) {
            print('RoadCurbStone with id ${roadCurbStone.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post WaterTanker with id ${roadCurbStone.id}: $e');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted RoadCurbStone: $e');
      }
    }
  }

  Future<void> postRoadCurbStoneToAPI(RoadCurbStonesWorkModel roadCurbStonesWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      var roadCurbStonesWorkModelData = roadCurbStonesWorkModel.toMap();
      final response = await http.post(
        Uri.parse(Config.postApiUrlRoadCurbStone),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(roadCurbStonesWorkModelData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {

      throw Exception('Failed to post data: $e');
    }
  }

  fetchAndSaveRoadsCurbStonesWorkData() async {
    await roadCurbStonesWorkRepository.fetchAndSaveRoadCompactionData();
  }

  addRoadCurb(RoadCurbStonesWorkModel roadCurbStonesWorkModel) {
    roadCurbStonesWorkRepository.add(roadCurbStonesWorkModel);
  }

  updateRoadCurb(RoadCurbStonesWorkModel roadCurbStonesWorkModel) {
    roadCurbStonesWorkRepository.update(roadCurbStonesWorkModel);
    fetchAllRoadCurb();
  }

  deleteRoadCurb(int id) {
    roadCurbStonesWorkRepository.delete(id);
    fetchAllRoadCurb();
  }
}
