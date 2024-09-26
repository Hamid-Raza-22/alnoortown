import 'package:al_noor_town/Models/BlocksDetailsModels/blocks_details_models.dart';
import 'package:al_noor_town/Repositories/BlockDetailsRepositories/block_details_repository.dart';
import 'package:get/get.dart';
class BlockDetailsViewModel extends GetxController {

  var allBlockDetails = <BlocksDetailsModels>[].obs;
  BlockDetailsRepository blockDetailsRepository = BlockDetailsRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllLight();
  }
  // Future<void> postDataFromDatabaseToAPI() async {
  //   try {
  //     // Step 1: Fetch machines that haven't been posted yet
  //     var unPostedLightPoles = await lightWiresRepository.getUnPostedLightWires();
  //
  //     for (var lightPoles in unPostedLightPoles) {
  //       try {
  //         // Step 2: Attempt to post the data to the API
  //         await postLightWiresToAPI(lightPoles);
  //
  //         // Step 3: If successful, update the posted status in the local database
  //         lightPoles.posted = 1;
  //         await lightWiresRepository.update(lightPoles);
  //
  //         // Optionally, delete the machine from the local database after posting
  //         // await machineRepository.delete(machine.id);
  //
  //         if (kDebugMode) {
  //           print('LightPoles with id ${lightPoles.id} posted and updated in local database.');
  //         }
  //       } catch (e) {
  //         if (kDebugMode) {
  //           print('Failed to post LightPoles with id ${lightPoles.id}: $e');
  //         }
  //         // Handle any errors (e.g., server down, network issues)
  //       }
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error fetching unPosted LightPoles: $e');
  //     }
  //   }
  // }
  //
  // // Function to post data to the API
  // Future<void> postLightWiresToAPI(LightWiresModel lightWiresModel) async {
  //   try {
  //     await Config.fetchLatestConfig();
  //     print('Updated LightPoles Post API: ${Config.postApiUrlLightWires}');
  //     var lightWiresModelData = lightWiresModel.toMap(); // Converts MachineModel to JSON
  //     final response = await http.post(
  //       Uri.parse(Config.postApiUrlLightWires),
  //       headers: {
  //         "Content-Type": "application/json",  // Set the request content type to JSON
  //         "Accept": "application/json",
  //       },
  //       body: jsonEncode(lightWiresModelData),  // Encode the map as JSON
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print('LightPoles data posted successfully: $lightWiresModelData');
  //     } else {
  //       throw Exception('Server error: ${response.statusCode}, ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error posting LightPoles data: $e');
  //     throw Exception('Failed to post data: $e');
  //   }
  // }

  fetchAllBlockDetails() async{
    var blockDetails = await blockDetailsRepository.getBlockDetails();
    allBlockDetails.value = blockDetails;

  }
  fetchAndSaveBlockDetailsData() async {
    await blockDetailsRepository.fetchAndSaveBlockDetails();
  }
  addBlockDetails(BlocksDetailsModels blocksDetailsModels){
    blockDetailsRepository.add(blocksDetailsModels);
    //fetchAllLight();
  }

  updateBlockDetails(BlocksDetailsModels blocksDetailsModels){
    blockDetailsRepository.update(blocksDetailsModels);
    fetchAllBlockDetails();
  }

  deleteBlockDetails(int id){
    blockDetailsRepository.delete(id);
    fetchAllBlockDetails();
  }

}

