
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCurbstonesWorkModel/road_curb_stones_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsCurbStonesWorkRepuository/road_curb_stones_work_repository.dart';
import 'package:get/get.dart';

class RoadCurbStonesWorkViewModel extends GetxController {

  var allRoadCurb = <RoadCurbStonesWorkModel>[].obs;
  RoadCurbStonesWorkRepository roadCurbStonesWorkRepository = RoadCurbStonesWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllRoadCurb() async{
    var roadCurb = await roadCurbStonesWorkRepository.getRoadCurbStonesWork();
    allRoadCurb.value = roadCurb;

  }

  addRoadCurb(RoadCurbStonesWorkModel roadCurbStonesWorkModel){
    roadCurbStonesWorkRepository.add(roadCurbStonesWorkModel);

  }

  updateRoadCurb(RoadCurbStonesWorkModel roadCurbStonesWorkModel){
    roadCurbStonesWorkRepository.update(roadCurbStonesWorkModel);
    fetchAllRoadCurb();
  }

  deleteRoadCurb(int id){
    roadCurbStonesWorkRepository.delete(id);
    fetchAllRoadCurb();
  }

}

