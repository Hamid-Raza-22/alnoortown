import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/machine_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/RoadMaintenaceRepositories/machine_repository.dart';
import 'package:al_noor_town/Services/ApiServices/api_constants.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Globals/globals.dart';

class MachineViewModel extends GetxController {
  var allMachines = <MachineModel>[].obs;
  var filteredMachines = <MachineModel>[].obs;
  MachineRepository machineRepository = MachineRepository();
 ApiService apiService = ApiService(baseUrl: ApiConstants.baseUrl);

  @override
  void onInit() {
    super.onInit();
    fetchAllMachines();
    fetchAndInsertMachinesFromAPI();
  }
  fetchAndSaveMachineData() async {
    await machineRepository.fetchAndSaveMachineData();
  }
  Future<void> fetchAllMachines() async {
    var machines = await machineRepository.getMachine();
    allMachines.value = machines;
    filteredMachines.value = machines; // Initialize filteredMachines with all data
  }

  addMachine(MachineModel machineModel) {
    machineRepository.add(machineModel);
    fetchAllMachines();
  }

  void updateMachine(MachineModel machineModel) {
    machineRepository.update(machineModel);
    fetchAllMachines();
  }

  void deleteMachine(int? id) {
    machineRepository.delete(id);
    fetchAllMachines();
  }

  Future<void> fetchAndInsertMachinesFromAPI() async {
    try {
      // Fetch data from API
      var response = await http.get(Uri.parse('${Config.getApiUrlMachine}$userId'));

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the response body
        var responseData = jsonDecode(response.body);

        // Check if the response contains machine data
        if (responseData != null && responseData is List) {
          // Iterate through the response and insert each machine into the database
          for (var machineData in responseData) {
            machineData['posted'] = 1; // Set posted to 1
            MachineModel machineModel = MachineModel.fromMap(machineData);
            await machineRepository.add(machineModel);
          }
          // After inserting, fetch all machines from the database
          fetchAllMachines();
        }
      } else {
        // Handle the case where the response is not successful
        if (kDebugMode) {
          print("Error: ${response.statusCode}");
        }
      }
    } catch (e) {
      // Handle any errors during the API call or data insertion
      if (kDebugMode) {
        print("Error fetching or inserting machines: $e");
      }
    }
  }

  Future<void> postDataFromDatabaseToAPI() async {
    try {
      // Step 1: Fetch machines that haven't been posted yet
      var unPostedMachines = await machineRepository.getUnPostedMachines();

      for (var machine in unPostedMachines) {
        try {
          // Step 2: Attempt to post the data to the API
          await postMachineToAPI(machine);

          // Step 3: If successful, update the posted status in the local database
          machine.posted = 1;
          await machineRepository.update(machine);

          // Optionally, delete the machine from the local database after posting
          // await machineRepository.delete(machine.id);

          if (kDebugMode) {
            print('Machine with id ${machine
              .id} posted and updated in local database.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to post machine with id ${machine.id}: $e');
          }
          // Handle any errors (e.g., server down, network issues)
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unPosted machines: $e');
      }
    }
  }
  Future<void> postMachineToAPI(MachineModel machineModel) async {
    try {
      await Config.fetchLatestConfig();
      if (kDebugMode) {
        print('Updated Machine Post API: ${Config.postApiUrlMachine}');
      }
      var machineData = machineModel.toMap(); // Converts MachineModel to JSON
      final response = await http.post(
        Uri.parse(Config.postApiUrlMachine),  // Use the URL from Remote Config
        headers: {
          "Content-Type": "application/json",  // Set the request content type to JSON
          "Accept": "application/json",
        },
        body: jsonEncode(machineData),  // Encode the map as JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Machine data posted successfully: $machineData');
      } else {
        throw Exception('Server error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error posting machine data: $e');
      throw Exception('Failed to post data: $e');
    }
  }



  // Method to filter machines based on user-friendly search criteria
  void applyFilters({
    String? blockNumber,
    String? streetNumber,
    DateTime? start_date,
    DateTime? endDate,
  }) {
    filteredMachines.value = allMachines.where((machine) {
      final matchesBlockNumber = blockNumber == null || blockNumber.isEmpty || machine.block_no?.contains(blockNumber) == true;
      final matchesStreetNumber = streetNumber == null || streetNumber.isEmpty || machine.street_no?.contains(streetNumber) == true;

      final matchesstart_date = start_date == null || (machine.date != null && (machine.date!.isAfter(start_date) || machine.date!.isAtSameMomentAs(start_date)));
      final matchesEndDate = endDate == null || (machine.date != null && (machine.date!.isBefore(endDate) || machine.date!.isAtSameMomentAs(endDate)));

      return matchesBlockNumber && matchesStreetNumber && matchesstart_date && matchesEndDate;
    }).toList();
  }
}
