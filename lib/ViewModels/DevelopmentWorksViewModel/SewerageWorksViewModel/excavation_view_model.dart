
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/excavation_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/SewerageWorksRepositries/excavation_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
class ExcavationViewModel extends GetxController {

  var allExa = <ExcavationModel>[].obs;
  ExcavationRepository excavationRepository = ExcavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllExa ()
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedExcavationSewerageWorks = await excavationRepository.getUnPostedExcavationSewerageWorks();

      for (var excavationSewerageWorks in unPostedExcavationSewerageWorks) {
        try {
          // Step 2: Attempt to post the data to the API
          await postedExcavationSewerageWorksToAPI(excavationSewerageWorks);

          // Step 3: If successful, update the posted status in the local database
          excavationSewerageWorks.posted = 1;
          await excavationRepository.update(excavationSewerageWorks);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('ExcavationSewerageWorks with id ${excavationSewerageWorks.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post ExcavationSewerageWorks with id ${excavationSewerageWorks.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted ExcavationSewerageWorks: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postedExcavationSewerageWorksToAPI(ExcavationModel excavationModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated ExcavationSewerageWorks Post API: ${Config.postApiUrlWaterTanker}');
      var excavationModelData = excavationModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(excavationModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('ExcavationSewerageWorks data posted successfully: $excavationModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting ExcavationSewerageWorks data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllExa() async{
    var excavation = await excavationRepository.getExcavation();
    allExa .value = excavation;

  }

  addExa(ExcavationModel excavationModel){
    excavationRepository.add(excavationModel);
    //fetchAllExa();
  }

  updateExa(ExcavationModel excavationModel){
    excavationRepository.update(excavationModel);
    fetchAllExa();
  }

  deleteExa(int id){
    excavationRepository.delete(id);
    fetchAllExa();
  }

}

