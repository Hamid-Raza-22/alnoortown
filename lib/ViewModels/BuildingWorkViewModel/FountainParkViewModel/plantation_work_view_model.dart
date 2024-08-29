
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/plantation_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/plantation_work_repository.dart';
import 'package:get/get.dart';

class PlantationWorkViewModel extends GetxController {

  var allPlant = <PlantationWorkModel>[].obs;
  PlantationWorkRepository plantationWorkRepository = PlantationWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllPlant() async{
    var plant = await plantationWorkRepository.getPlantationWork();
    allPlant.value = plant;

  }

  addPlant(PlantationWorkModel plantationWorkModel){
    plantationWorkRepository.add(plantationWorkModel);

  }

  updatePlant(PlantationWorkModel plantationWorkModel){
    plantationWorkRepository.update(plantationWorkModel);
    fetchAllPlant();
  }

  deleteMud(int id){
    plantationWorkRepository.delete(id);
    fetchAllPlant();
  }

}

