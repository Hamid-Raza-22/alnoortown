
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/paint_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/paint_work_repository,.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class PaintWorkViewModel extends GetxController {

  var allPaint = <PaintWorkModel>[].obs;
  PaintWorkRepository paintWorkRepository = PaintWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPaintWork = await paintWorkRepository.getUnPostedPaintWork();

      for (var paintWork in unPostedPaintWork) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPaintWorkToAPI(paintWork);

          // Step 3: If successful, update the posted status in the local database
          paintWork.posted = 1;
          await paintWorkRepository.update(paintWork);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('PaintWork with id ${paintWork.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post PaintWork with id ${paintWork.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted PaintWork: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postPaintWorkToAPI(PaintWorkModel paintWorkModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated PaintWork Post API: ${Config.waterTankerPostApi}');
      var paintWorkModelData = paintWorkModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.waterTankerPostApi),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(paintWorkModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('PaintWork data posted successfully: $paintWorkModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting PaintWork data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllPaint() async{
    var paintJob = await paintWorkRepository.getPaintWork();
    allPaint.value = paintJob;

  }

  addPaint(PaintWorkModel paintWorkModel){
    paintWorkRepository.add(paintWorkModel);

  }

  updatePaint(PaintWorkModel paintWorkModel){
    paintWorkRepository.update(paintWorkModel);
    fetchAllPaint();
  }

  deletePaint(int id){
    paintWorkRepository.delete(id);
    fetchAllPaint();
  }

}

