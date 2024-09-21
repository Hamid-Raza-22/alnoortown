
import 'package:al_noor_town/Models/NewMaterialModels/new_material_model.dart';
import 'package:al_noor_town/Repositories/NewMaterialRepositories/new_material_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class NewMaterialViewModel extends GetxController {

  var allNew = <NewMaterialModel>[].obs;
  NewMaterialRepository newMaterialRepository = NewMaterialRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllNewMaterial ();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedNewMaterials = await newMaterialRepository.getUnPostedNewMaterial();

      for (var newMaterials in unPostedNewMaterials) {
        try {
          // Step 2: Attempt to post the data to the API
          await postNewMaterialsToAPI(newMaterials);

          // Step 3: If successful, update the posted status in the local database
          newMaterials.posted = 1;
          await newMaterialRepository.update(newMaterials);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('NewMaterials with id ${newMaterials.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post NewMaterials with id ${newMaterials.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted NewMaterials: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postNewMaterialsToAPI(NewMaterialModel newMaterialModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated NewMaterials Post API: ${Config.waterTankerPostApi}');
      var newMaterialModelData = newMaterialModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.waterTankerPostApi),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(newMaterialModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('NewMaterials data posted successfully: $newMaterialModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting NewMaterials data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllNewMaterial() async{
    var material = await newMaterialRepository.getNewMaterial();
    allNew .value = material;

  }

  addNewMaterial(NewMaterialModel newMaterialModel){
    newMaterialRepository.add(newMaterialModel);
    fetchAllNewMaterial();
  }

  updateNewMaterial(NewMaterialModel newMaterialModel){
    newMaterialRepository.update(newMaterialModel);
    fetchAllNewMaterial();
  }

  deleteNew(int id){
    newMaterialRepository.delete(id);
    fetchAllNewMaterial();
  }
}
