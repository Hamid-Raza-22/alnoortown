
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/gazebo_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/gazebo_work_repository.dart';
import 'package:get/get.dart';

class GazeboWorkViewModel extends GetxController {

  var allGazebo = <GazeboWorkModel>[].obs;
  GazeboWorkRepository gazeboWorkRepository = GazeboWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllGazebo() async{
    var gazebo = await gazeboWorkRepository.getGazeboWork();
    allGazebo.value = gazebo;

  }

  addGazebo(GazeboWorkModel gazeboWorkModel){
    gazeboWorkRepository.add(gazeboWorkModel);

  }

  updateGazebo(GazeboWorkModel gazeboWorkModel){
    gazeboWorkRepository.update(gazeboWorkModel);
    fetchAllGazebo();
  }

  deleteGazebo(int id){
    gazeboWorkRepository.delete(id);
    fetchAllGazebo();
  }

}

