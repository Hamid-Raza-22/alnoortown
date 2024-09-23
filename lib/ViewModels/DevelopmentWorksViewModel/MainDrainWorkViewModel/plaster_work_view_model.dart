
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/plaster_work_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/plaster_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class PlasterWorkViewModel extends GetxController {

  var allPlaster = <PlasterWorkModel>[].obs;
  PlasterWorkRepository plasterWorkRepository = PlasterWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
   // fetchAllPlaster ();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPlasterwork = await plasterWorkRepository.getUnPostedPlasterWork();

      for (var plasterwork in unPostedPlasterwork) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPlasterworkToAPI(plasterwork);

          // Step 3: If successful, update the posted status in the local database
          plasterwork.posted = 1;
          await plasterWorkRepository.update(plasterwork);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('Plasterwork with id ${plasterwork.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post Plasterwork with id ${plasterwork.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted Plasterwork: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postPlasterworkToAPI(PlasterWorkModel plasterWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated Plasterwork Post API: ${Config.postApiUrlPlasterWork}');
      var plasterWorkModelData = plasterWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlPlasterWork),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(plasterWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Plasterwork data posted successfully: $plasterWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting Plasterwork data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllPlaster() async{
    var work = await plasterWorkRepository.getPlasterWork();
    allPlaster .value = work;

  }

  addMan(PlasterWorkModel plasterWorkModel){
    plasterWorkRepository.add(plasterWorkModel);
   // fetchAllPlaster();
  }

  updateMan(PlasterWorkModel plasterWorkModel){
    plasterWorkRepository.update(plasterWorkModel);
    fetchAllPlaster();
  }

  deleteMan(int id){
    plasterWorkRepository.delete(id);
    fetchAllPlaster();
  }

}

