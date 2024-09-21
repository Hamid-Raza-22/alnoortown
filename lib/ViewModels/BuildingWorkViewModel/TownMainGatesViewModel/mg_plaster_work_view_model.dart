
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/mg_plaster_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/TownMainGatesRepository/mg_plaster_work_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class MgPlasterWorkViewModel extends GetxController {

  var allMgPlaster = <MgPlasterWorkModel>[].obs;
  MgPlasterWorkRepository mgPlasterWorkRepository = MgPlasterWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMainGatePlaster = await mgPlasterWorkRepository.getUnPostedMainGatePlaster();

      for (var mainGatePlaster in unPostedMainGatePlaster) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMainGatePlasterToAPI(mainGatePlaster);

          // Step 3: If successful, update the posted status in the local database
          mainGatePlaster.posted = 1;
          await mgPlasterWorkRepository.update(mainGatePlaster);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('MainGatePlaster with id ${mainGatePlaster.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post MainGatePlaster with id ${mainGatePlaster.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted MainGatePlaster: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postMainGatePlasterToAPI(MgPlasterWorkModel mgPlasterWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated MainGatePlaster Post API: ${Config.waterTankerPostApi}');
      var mgPlasterWorkModelData = mgPlasterWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.waterTankerPostApi),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(mgPlasterWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('MainGatePlaster data posted successfully: $mgPlasterWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting MainGatePlaster data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllMgPlaster() async{
    var mgPlaster = await mgPlasterWorkRepository.getMgPlasterWork();
    allMgPlaster.value = mgPlaster;

  }

  addMgPlaster(MgPlasterWorkModel mgPlasterWorkModel){
    mgPlasterWorkRepository.add(mgPlasterWorkModel);

  }

  updateMgPlaster(MgPlasterWorkModel mgPlasterWorkModel){
    mgPlasterWorkRepository.update(mgPlasterWorkModel);
    fetchAllMgPlaster();
  }

  deleteMgPlaster(int id){
    mgPlasterWorkRepository.delete(id);
    fetchAllMgPlaster();
  }

}

