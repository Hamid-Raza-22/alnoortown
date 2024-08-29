
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/main_stage_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/main_stage_work_repository.dart';
import 'package:get/get.dart';

class MainStageWorkViewModel extends GetxController {

  var allStage = <MainStageWorkModel>[].obs;
  MainStageWorkRepository mainStageWorkRepository = MainStageWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllStage() async{
    var stage = await mainStageWorkRepository.getMainStageWork();
    allStage.value = stage;

  }

  addStage(MainStageWorkModel mainStageWorkModel){
    mainStageWorkRepository.add(mainStageWorkModel);

  }

  updateStage(MainStageWorkModel mainStageWorkModel){
    mainStageWorkRepository.update(mainStageWorkModel);
    fetchAllStage();
  }

  deleteStage(int id){
    mainStageWorkRepository.delete(id);
    fetchAllStage();
  }

}

