
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsShoulderWorkModel/roads_shoulder_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsShoulderWorkRepository/roads_shoulder_work_repository.dart';
import 'package:get/get.dart';

class RoadsShoulderWorkViewModel extends GetxController {

  var allRoadShoulder = <RoadsShoulderWorkModel>[].obs;
  RoadsShoulderWorkRepository roadsShoulderWorkRepository = RoadsShoulderWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllRoadShoulder() async{
    var roadsShoulder = await roadsShoulderWorkRepository.getRoadsShoulderWork();
    allRoadShoulder.value = roadsShoulder;

  }

  addRoadShoulder(RoadsShoulderWorkModel roadsShoulderWorkModel){
    roadsShoulderWorkRepository.add(roadsShoulderWorkModel);

  }

  updateRoadShoulder(RoadsShoulderWorkModel roadsShoulderWorkModel){
    roadsShoulderWorkRepository.update(roadsShoulderWorkModel);
    fetchAllRoadShoulder();
  }

  deleteRoadShoulder(int id){
    roadsShoulderWorkRepository.delete(id);
    fetchAllRoadShoulder();
  }

}

