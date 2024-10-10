import'dart:convert';
import 'package:al_noor_town/Models/AttendenceModels/attendance_out_model.dart';
import 'package:al_noor_town/Repositories/AttendanceRepositories/attendance_out_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AttendanceOutViewModel extends GetxController {

  var allAttendOut = <AttendanceOutModel>[].obs;
  AttendanceOutRepository attendanceOutRepository = AttendanceOutRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllBrick();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedAttendanceOut = await attendanceOutRepository.getUnPostedAttendanceOut();

      for (var attendanceOut in unPostedAttendanceOut) {
        try {
          // Step 2: Attempt to post the data to the API
          await postAttendanceOutToAPI(attendanceOut);

          // Step 3: If successful, update the posted status in the local database
          attendanceOut.posted = 1;
          await attendanceOutRepository.update(attendanceOut);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('AttendanceOut with id ${attendanceOut.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post AttendanceOut with id ${attendanceOut.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted AttendanceOut: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postAttendanceOutToAPI(AttendanceOutModel attendanceOutModel) async {
    try {
      await Config.fetchLatestConfig();
      if (kDebugMode) {
        print('Updated AttendanceOut Post API: ${Config.postApiUrlAttendanceOut}');
      }
      var attendanceOutModelData = attendanceOutModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlAttendanceOut),         headers: {
        "Content-Type": "application/json",  // Set the request content type to JSON
        "Accept": "application/json",
      },
        body: jsonEncode(attendanceOutModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('AttendanceOut data posted successfully: $attendanceOutModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting AttendanceOut data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllAttendOut() async{
    var attendanceOut = await attendanceOutRepository.getAttendanceOut();
    allAttendOut .value = attendanceOut;

  }
  fetchAndSaveAttendanceOutData() async {
    await attendanceOutRepository.fetchAndSaveAttendanceOutData();
  }

  addAttendOut(AttendanceOutModel attendanceOutModel){
    attendanceOutRepository.add(attendanceOutModel);
    //fetchAllBrick();
  }

  updateAttendOut(AttendanceOutModel attendanceOutModel){
    attendanceOutRepository.update(attendanceOutModel);
    fetchAllAttendOut();
  }

  deleteAttendOut(int id){
    attendanceOutRepository.delete(id);
    fetchAllAttendOut();
  }

}

