import 'package:al_noor_town/Models/RoadsDetailModels/roads_detail_models.dart';
import 'package:al_noor_town/Repositories/RoadDetailsRepositories/road_details_repository.dart';
import 'package:get/get.dart';
class RoadDetailsViewModel extends GetxController {

  var allRoadDetails = <RoadsDetailModels>[].obs;
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

