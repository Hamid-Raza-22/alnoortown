
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsWaterSupplyWorkModel/water_first_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsWaterSupplyWorkRepository/water_first_repository.dart';
import 'package:get/get.dart';

class WaterFirstViewModel extends GetxController {

  var allWaterFirst = <WaterFirstModel>[].obs;
  WaterFirstRepository waterFirstRepository = WaterFirstRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllWaterFirst() async{
    var waterFirst = await waterFirstRepository.getWaterFirst();
    allWaterFirst.value = waterFirst;

  }

  addWaterFirst(WaterFirstModel waterFirstModel){
    waterFirstRepository.add(waterFirstModel);

  }

  updateWaterFirst(WaterFirstModel waterFirstModel){
    waterFirstRepository.update(waterFirstModel);
    fetchAllWaterFirst();
  }

  deleteWaterFirst(int id){
    waterFirstRepository.delete(id);
    fetchAllWaterFirst();
  }

}

