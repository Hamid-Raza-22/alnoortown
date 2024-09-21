import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/mosque_excavation_work.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/mosque_exavation_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class MosqueExcavationViewModel extends GetxController {

  var allMosque = <MosqueExcavationWorkModel>[].obs;
  MosqueExcavationRepository mosqueExcavationRepository = MosqueExcavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    // fetchAllMosque();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMosqueExcavation = await mosqueExcavationRepository.getUnPostedMosqueExcavation();

      for (var mosqueExcavation in unPostedMosqueExcavation) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMosqueExcavationToAPI(mosqueExcavation);

          // Step 3: If successful, update the posted status in the local database
          mosqueExcavation.posted = 1;
          await mosqueExcavationRepository.update(mosqueExcavation);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MosqueExcavation with id ${mosqueExcavation.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MosqueExcavation with id ${mosqueExcavation.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MosqueExcavation: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMosqueExcavationToAPI(MosqueExcavationWorkModel mosqueExcavationWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MosqueExcavation Post API: ${Config.postApiUrlWaterTanker}');
      var mosqueExcavationWorkModelData = mosqueExcavationWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(mosqueExcavationWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MosqueExcavation data posted successfully: $mosqueExcavationWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MosqueExcavation data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllMosque() async{
    var mosques = await mosqueExcavationRepository.getMosqueExcavation();
    allMosque.value = mosques;

  }

  addMosque(MosqueExcavationWorkModel mosqueExcavationWorkModel){
    mosqueExcavationRepository.add(mosqueExcavationWorkModel);
    //fetchAllMosque();
  }

  updateMosque(MosqueExcavationWorkModel mosqueExcavationWorkModel){
    mosqueExcavationRepository.update(mosqueExcavationWorkModel);
    fetchAllMosque();
  }

  deleteLight(int id){
    mosqueExcavationRepository.delete(id);
    fetchAllMosque();
  }

}

