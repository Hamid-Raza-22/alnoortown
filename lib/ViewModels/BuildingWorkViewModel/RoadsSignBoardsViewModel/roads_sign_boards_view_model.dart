
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsSignBoardsModel/roads_sign_boards_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsSignBoardsRepository/roads_sign_boards_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class RoadsSignBoardsViewModel extends GetxController {

  var allRoadsSignBoard = <RoadsSignBoardsModel>[].obs;
  RoadsSignBoardsRepository roadsSignBoardsRepository = RoadsSignBoardsRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedRoadsSignBoards= await roadsSignBoardsRepository.getUnPostedMachines();

      for (var roadsSignBoards in unPostedRoadsSignBoards) {
        try {
          // Step 2: Attempt to post the data to the API
          await postRoadsSignBoardsToAPI(roadsSignBoards);

          // Step 3: If successful, update the posted status in the local database
          roadsSignBoards.posted = 1;
          await roadsSignBoardsRepository.update(roadsSignBoards);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('RoadsSignBoards with id ${roadsSignBoards.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post RoadsSignBoards with id ${roadsSignBoards.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted RoadsSignBoards: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postRoadsSignBoardsToAPI(RoadsSignBoardsModel roadsSignBoardsModel) async {
    try {
      await Config.fetchLatestConfig();
      print('Updated RoadsSignBoards Post API: ${Config.postApiUrlRoadsSignBoards}');
      var roadsSignBoardsModelData = roadsSignBoardsModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlRoadsSignBoards),
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(roadsSignBoardsModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('RoadsSignBoards data posted successfully: $roadsSignBoardsModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting RoadsSignBoards data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllRoadsSignBoard() async{
    var roadsSignBoard = await roadsSignBoardsRepository.getRoadsSignBoards();
    allRoadsSignBoard.value = roadsSignBoard;

  }

  addRoadsSignBoard(RoadsSignBoardsModel roadsSignBoardsModel){
    roadsSignBoardsRepository.add(roadsSignBoardsModel);

  }

  updateRoadsSignBoard(RoadsSignBoardsModel roadsSignBoardsModel){
    roadsSignBoardsRepository.update(roadsSignBoardsModel);
    fetchAllRoadsSignBoard();
  }

  deleteRoadsSignBoard(int id){
    roadsSignBoardsRepository.delete(id);
    fetchAllRoadsSignBoard();
  }

}

