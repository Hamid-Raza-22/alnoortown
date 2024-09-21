
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/pipeline_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/SewerageWorksRepositries/pipeline_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
class PipelineViewModel extends GetxController {

  var allPipe = <PipelineModel>[].obs;
  PipelineRepository pipelineRepository = PipelineRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
   // fetchAllPipe ();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedPipelineWorks = await pipelineRepository.getUnPostedPipeLine();

      for (var pipelineWorks  in unPostedPipelineWorks) {
        try {
          // Step 2: Attempt to post the data to the API
          await postPipelineWorksToAPI(pipelineWorks);

          // Step 3: If successful, update the posted status in the local database
          pipelineWorks.posted = 1;
          await pipelineRepository.update(pipelineWorks);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('pipelineWorks with id ${pipelineWorks.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post pipelineWorks with id ${pipelineWorks.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted pipelineWorks: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postPipelineWorksToAPI(PipelineModel pipelineModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated PipelineWorks Post API: ${Config.postApiUrlWaterTanker}');
      var pipelineModelData = pipelineModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlWaterTanker),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(pipelineModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('PipelineWorks data posted successfully: $pipelineModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting PipelineWorks data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllPipe() async{
    var line = await pipelineRepository.getPipeline();
    allPipe .value = line;

  }

  addPipe(PipelineModel pipelineModel){
    pipelineRepository.add(pipelineModel);
    //fetchAllPipe();
  }

  updatePipe(PipelineModel pipelineModel){
    pipelineRepository.update(pipelineModel);
    fetchAllPipe();
  }

  deletePipe(int id){
    pipelineRepository.delete(id);
    fetchAllPipe();
  }

}

