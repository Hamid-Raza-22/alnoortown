import 'package:al_noor_town/Models/RoadsDetailModels/roads_detail_models.dart';
import 'package:al_noor_town/Repositories/RoadDetailsRepositories/road_details_repository.dart';
import 'package:get/get.dart';
class RoadDetailsViewModel extends GetxController {

  var allRoadDetails = <RoadsDetailModels>[].obs;
  var selectedBlock = ''.obs; // Observable for the selected block
  var filteredStreets = <String>[].obs; // Filtered list of streets based on block
  RoadDetailsRepository roadDetailsRepository = RoadDetailsRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllLight();
  }

  fetchAllRoadDetails() async{
    var roadDetails = await roadDetailsRepository.getRoadsDetails();
    allRoadDetails.value = roadDetails;

  }
  // Update the list of streets when a block is selected
  void updateFilteredStreets(String block) {
    selectedBlock.value = block;
    filteredStreets.value = allRoadDetails
        .where((detail) => detail.block == block)
        .map((detail) => detail.street.toString())
        .toSet()
        .toList();
  }
  fetchAndSaveRoadDetailsData() async {
    await roadDetailsRepository.fetchAndSaveRoadDetails();
    fetchAllRoadDetails();
  }
  addRoadDetails(RoadsDetailModels roadsDetailModels){
    roadDetailsRepository.add(roadsDetailModels);
    //fetchAllLight();
  }

  updateRoadDetails(RoadsDetailModels roadsDetailModels){
    roadDetailsRepository.update(roadsDetailModels);
    fetchAllRoadDetails();
  }

  deleteRoadDetails(int id){
    roadDetailsRepository.delete(id);
    fetchAllRoadDetails();
  }

}

