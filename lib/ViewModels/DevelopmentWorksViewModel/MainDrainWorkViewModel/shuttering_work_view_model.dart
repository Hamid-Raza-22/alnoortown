
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/shuttering_work_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/shuttering_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
class ShutteringWorkViewModel extends GetxController {

  var allShutter = <ShutteringWorkModel>[].obs;
  ShutteringWorkRepository shutteringWorkRepository = ShutteringWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllShutter ();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedShutteringWork = await shutteringWorkRepository.getUnPostedShutteringWork();

      for (var shutteringWork  in unPostedShutteringWork) {
        try {
          // Step 2: Attempt to post the data to the API
          await postShutteringWorkToAPI(shutteringWork);

          // Step 3: If successful, update the posted status in the local database
          shutteringWork.posted = 1;
          await shutteringWorkRepository.update(shutteringWork);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('shutteringWork with id ${shutteringWork.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post shutteringWork with id ${shutteringWork.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted shutteringWork: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postShutteringWorkToAPI(ShutteringWorkModel shutteringWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated Water Tanker Post API: ${Config.waterTankerPostApi}');
      var shutteringWorkModelData = shutteringWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.waterTankerPostApi),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(shutteringWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('shutteringWork data posted successfully: $shutteringWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting shutteringWork data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllShutter() async{
    var work = await shutteringWorkRepository.getShutteringWork();
    allShutter .value = work;

  }

  addShutter(ShutteringWorkModel shutteringWorkModel){
    shutteringWorkRepository.add(shutteringWorkModel);
    //fetchAllShutter();
  }

  updateShutter(ShutteringWorkModel shutteringWorkModel){
    shutteringWorkRepository.update(shutteringWorkModel);
    fetchAllShutter();
  }

  deleteShutter(int id){
    shutteringWorkRepository.delete(id);
    fetchAllShutter();
  }

}

