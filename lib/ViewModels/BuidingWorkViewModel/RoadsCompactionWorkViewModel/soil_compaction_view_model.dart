
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/soil_compaction_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsCompactionWorkRepository/soil_compaction_repository.dart';
import 'package:get/get.dart';

class SoilCompactionViewModel extends GetxController {

  var allSoil = <SoilCompactionModel>[].obs;
  SoilCompactionRepository soilCompactionRepository = SoilCompactionRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllSoil() async{
    var soil = await soilCompactionRepository.getSoilCompaction();
    allSoil.value = soil;

  }

  addSoil(SoilCompactionModel soilCompactionModel){
    soilCompactionRepository.add(soilCompactionModel);

  }

  updateSoil(SoilCompactionModel soilCompactionModel){
    soilCompactionRepository.update(soilCompactionModel);
    fetchAllSoil();
  }

  deleteSoil(int id){
    soilCompactionRepository.delete(id);
    fetchAllSoil();
  }

}

