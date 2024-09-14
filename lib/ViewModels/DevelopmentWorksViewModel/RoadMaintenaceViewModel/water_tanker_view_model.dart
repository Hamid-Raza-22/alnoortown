
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/water_tanker_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/RoadMaintenaceRepositories/water_tanker_repository.dart';
import 'package:get/get.dart';

class WaterTankerViewModel extends GetxController {

  var allTanker = <WaterTankerModel>[].obs;
  WaterTankerRepository waterTankerRepository = WaterTankerRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllTanker ();
  }

  fetchAllTanker() async{
    var tanker = await waterTankerRepository.getTanker();
    allTanker .value = tanker;

  }

  addTanker(WaterTankerModel waterTankerModel){
    waterTankerRepository.add(waterTankerModel);
    //fetchAllTanker();
  }

  updateTanker(WaterTankerModel waterTankerModel){
    waterTankerRepository.update(waterTankerModel);
    fetchAllTanker();
  }

  deleteTanker(int id){
    waterTankerRepository.delete(id);
    fetchAllTanker();
  }

}

