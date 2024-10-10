
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:al_noor_town/Models/AttendenceModels/attendance_in_model.dart';
import 'package:al_noor_town/Repositories/AttendanceRepositories/attendance_in_repository.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AttendanceInViewModel extends GetxController {

  var allAttend = <AttendanceInModel>[].obs;
  AttendanceInRepository attendanceInRepository = AttendanceInRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllBrick();
  }
  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMachines = await attendanceInRepository.getUnPostedAttendanceIn();

      for (var attendanceIn in unPostedMachines) {
        try {
          // Step 2: Attempt to post the data to the API
          await postAttendanceInToAPI(attendanceIn);

          // Step 3: If successful, update the posted status in the local database
          attendanceIn.posted = 1;
          await attendanceInRepository.update(attendanceIn);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('AttendanceIn with id ${attendanceIn.id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post AttendanceIn with id ${attendanceIn.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted AttendanceIn: $e');
      }
    }
  }

  // Function to post data to the API
  Future<void> postAttendanceInToAPI(AttendanceInModel attendanceInModel) async {
    try {
      await Config.fetchLatestConfig();
      if (kDebugMode) {
        print('Updated Attendance In Post API: ${Config.postApiUrlAttendanceIn}');
      }
      var attendanceInModelData = attendanceInModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlAttendanceIn),         headers: {
        "Content-Type": "application/json",  // Set the request content type to JSON
        "Accept": "application/json",
      },
        body: jsonEncode(attendanceInModelData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('AttendanceIn data posted successfully: $attendanceInModelData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting AttendanceIn data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  fetchAllAttend() async{
    var attendance = await attendanceInRepository.getAttendanceIn();
    allAttend .value = attendance;

  }
  fetchAndSaveAttendanceInData() async {
    await attendanceInRepository.fetchAndSaveAttendanceData();
  }
  addAttend(AttendanceInModel attendanceInModel){
    attendanceInRepository.add(attendanceInModel);
    //fetchAllBrick();
  }

  updateAttend(AttendanceInModel attendanceInModel){
    attendanceInRepository.update(attendanceInModel);
    fetchAllAttend();
  }

  deleteAttend(int id){
    attendanceInRepository.delete(id);
    fetchAllAttend();
  }

}

