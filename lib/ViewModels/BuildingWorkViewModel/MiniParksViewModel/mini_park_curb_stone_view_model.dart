
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mini_park_curb_stone_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/mini_park_curb_stone_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class MiniParkCurbStoneViewModel extends GetxController {

  var allMpCurb = <MiniParkCurbStoneModel>[].obs;
  MiniParkCurbStoneRepository miniParkCurbStoneRepository = MiniParkCurbStoneRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMiniParkCurbStone = await miniParkCurbStoneRepository.getUnPostedCurbStoneMp();

      for (var miniParkCurbStone in unPostedMiniParkCurbStone) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMiniParkCurbStoneToAPI(miniParkCurbStone);

          // Step 3: If successful, update the posted status in the local database
          miniParkCurbStone.posted = 1;
          await miniParkCurbStoneRepository.update(miniParkCurbStone);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MiniParkCurbStone with id ${miniParkCurbStone.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MiniParkCurbStone with id ${miniParkCurbStone.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MiniParkCurbStone: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMiniParkCurbStoneToAPI(MiniParkCurbStoneModel miniParkCurbStoneModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated  MiniParkCurbStone Post API: ${Config.postApiUrlWaterTanker}');
      var miniParkCurbStoneModelData = miniParkCurbStoneModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(miniParkCurbStoneModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MiniParkCurbStone data posted successfully: $miniParkCurbStoneModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MiniParkCurbStone data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllMpCurb() async{
    var mpCurb = await miniParkCurbStoneRepository.getMiniParkCurbStone();
    allMpCurb.value = mpCurb;

  }

  addMpCurb(MiniParkCurbStoneModel miniParkCurbStoneModel){
    miniParkCurbStoneRepository.add(miniParkCurbStoneModel);

  }

  updateMpCurb(MiniParkCurbStoneModel miniParkCurbStoneModel){
    miniParkCurbStoneRepository.update(miniParkCurbStoneModel);
    fetchAllMpCurb();
  }

  deleteMpCurb(int id){
    miniParkCurbStoneRepository.delete(id);
    fetchAllMpCurb();
  }

}

