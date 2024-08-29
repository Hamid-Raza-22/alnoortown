
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/cubstones_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/cubstones_work_repository.dart';
import 'package:get/get.dart';

class CubStonesWorkViewModel extends GetxController {

  var allCubStones = <CubStonesWorkModel>[].obs;
  CubStonesWorkRepository cubStonesWorkRepository = CubStonesWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllCubStones() async{
    var cubStones = await cubStonesWorkRepository.getCubStonesWork();
    allCubStones.value = cubStones;

  }

  addCubStones(CubStonesWorkModel cubStonesWorkModel){
    cubStonesWorkRepository.add(cubStonesWorkModel);

  }

  updateCubStones(CubStonesWorkModel cubStonesWorkModel){
    cubStonesWorkRepository.update(cubStonesWorkModel);
    fetchAllCubStones();
  }

  deleteCubStones(int id){
    cubStonesWorkRepository.delete(id);
    fetchAllCubStones();
  }

}

