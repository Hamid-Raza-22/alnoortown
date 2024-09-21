import 'dart:convert';
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/boundary_grill_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/boundary_grill_work_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class BoundaryGrillWorkViewModel extends GetxController {

  var allBoundary = <BoundaryGrillWorkModel>[].obs;
  BoundaryGrillWorkRepository boundaryGrillWorkRepository = BoundaryGrillWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    // fetchAllBoundary();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedBoundaryGrill = await boundaryGrillWorkRepository.getUnPostedBoundaryGrill();

      for (var boundaryGrill in unPostedBoundaryGrill) {
        try {
          // Step 2: Attempt to post the data to the API
          await postBoundaryGrillToAPI(boundaryGrill);

          // Step 3: If successful, update the posted status in the local database
          boundaryGrill.posted = 1;
          await boundaryGrillWorkRepository.update(boundaryGrill);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('Boundary Grill with id ${boundaryGrill.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post BoundaryGrill with id ${boundaryGrill.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted BoundaryGrill: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postBoundaryGrillToAPI(BoundaryGrillWorkModel boundaryGrillWorkModel) async {
    try {
      var boundaryGrillWorkModelData = boundaryGrillWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse('http://103.149.32.30:8080/ords/alnoor_town/watertanker/post/'),  // Ensure this is the correct URL
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(boundaryGrillWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('BoundaryGrill data posted successfully: $boundaryGrillWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting BoundaryGrill data: $e');
      throw Exception('Failed to post data: $e');
    }
  }
  fetchAllBoundary() async{
    var boundary = await boundaryGrillWorkRepository.getBoundaryGrillWork();
    allBoundary.value = boundary;

  }

  addBoundary(BoundaryGrillWorkModel boundaryGrillWorkModel){
    boundaryGrillWorkRepository.add(boundaryGrillWorkModel);

  }

  updateBoundary(BoundaryGrillWorkModel boundaryGrillWorkModel){
    boundaryGrillWorkRepository.update(boundaryGrillWorkModel);
    fetchAllBoundary();
  }

  deleteBoundary(int id){
    boundaryGrillWorkRepository.delete(id);
    fetchAllBoundary();
  }

}

