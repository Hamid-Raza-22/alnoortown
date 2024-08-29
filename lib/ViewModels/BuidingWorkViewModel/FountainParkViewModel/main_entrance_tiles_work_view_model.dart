
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/main_entrance_tiles_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/main_entrance_tiles_work_repository.dart';
import 'package:get/get.dart';

class MainEntranceTilesWorkViewModel extends GetxController {

  var allEntrance = <MainEntranceTilesWorkModel>[].obs;
  MainEntranceTilesWorkRepository mainEntranceTilesWorkRepository = MainEntranceTilesWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllEntrance() async{
    var entrance = await mainEntranceTilesWorkRepository.getMainEntranceTilesWork();
    allEntrance.value = entrance;

  }

  addEntrance(MainEntranceTilesWorkModel mainEntranceTilesWorkModel){
    mainEntranceTilesWorkRepository.add(mainEntranceTilesWorkModel);

  }

  updateEntrance(MainEntranceTilesWorkModel mainEntranceTilesWorkModel){
    mainEntranceTilesWorkRepository.update(mainEntranceTilesWorkModel);
    fetchAllEntrance();
  }

  deleteEntrance(int id){
    mainEntranceTilesWorkRepository.delete(id);
    fetchAllEntrance();
  }

}

