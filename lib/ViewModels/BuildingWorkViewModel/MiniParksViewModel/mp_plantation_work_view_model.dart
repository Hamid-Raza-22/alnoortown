
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mp_plantation_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/mp_plantation_work_repository.dart';
import 'package:get/get.dart';

class MpPlantationWorkViewModel extends GetxController {

  var allMpPlant = <MpPlantationWorkModel>[].obs;
  MpPlantationWorkRepository mpPlantationWorkRepository = MpPlantationWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllMpPlant() async{
    var mpPlant = await mpPlantationWorkRepository.getMpPlantationWork();
    allMpPlant.value = mpPlant;

  }

  addMpPlant(MpPlantationWorkModel mpPlantationWorkModel){
    mpPlantationWorkRepository.add(mpPlantationWorkModel);

  }

  updateMpPlant(MpPlantationWorkModel mpPlantationWorkModel){
    mpPlantationWorkRepository.update(mpPlantationWorkModel);
    fetchAllMpPlant();
  }

  deleteMpPlant(int id){
    mpPlantationWorkRepository.delete(id);
    fetchAllMpPlant();
  }

}

