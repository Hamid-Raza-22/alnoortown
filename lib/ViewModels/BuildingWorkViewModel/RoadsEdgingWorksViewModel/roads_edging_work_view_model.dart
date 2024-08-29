
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsEdgingWorkModel/roads_edging_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsEdgingWorksRepository/roads_edging_work_repository.dart';
import 'package:get/get.dart';

class RoadsEdgingWorkViewModel extends GetxController {

  var allRoadEdging = <RoadsEdgingWorkModel>[].obs;
  RoadsEdgingWorkRepository roadsEdgingWorkRepository = RoadsEdgingWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllRoadEdging() async{
    var roadEdging = await roadsEdgingWorkRepository.getRoadsEdgingWork();
    allRoadEdging.value = roadEdging;

  }

  addRoadEdging(RoadsEdgingWorkModel roadsEdgingWorkModel){
    roadsEdgingWorkRepository.add(roadsEdgingWorkModel);

  }

  updateRoadEdging(RoadsEdgingWorkModel roadsEdgingWorkModel){
    roadsEdgingWorkRepository.update(roadsEdgingWorkModel);
    fetchAllRoadEdging();
  }

  deleteRoadEdging(int id){
    roadsEdgingWorkRepository.delete(id);
    fetchAllRoadEdging();
  }

}

