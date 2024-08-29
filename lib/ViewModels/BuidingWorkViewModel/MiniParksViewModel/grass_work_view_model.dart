
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/grass_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/grass_work_repository.dart';
import 'package:get/get.dart';

class GrassWorkViewModel extends GetxController {

  var allGrass = <GrassWorkModel>[].obs;
  GrassWorkRepository grassWorkRepository = GrassWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllGrass() async{
    var grass = await grassWorkRepository.getGrassWork();
    allGrass.value = grass;

  }

  addGrass(GrassWorkModel grassWorkModel){
    grassWorkRepository.add(grassWorkModel);

  }

  updateGrass(GrassWorkModel grassWorkModel){
    grassWorkRepository.update(grassWorkModel);
    fetchAllGrass();
  }

  deleteGrass(int id){
    grassWorkRepository.delete(id);
    fetchAllGrass();
  }

}

