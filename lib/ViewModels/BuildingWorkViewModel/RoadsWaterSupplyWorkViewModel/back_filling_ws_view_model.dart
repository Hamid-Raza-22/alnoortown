
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsWaterSupplyWorkModel/back_filling_ws_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsWaterSupplyWorkRepository/back_filling_ws_repository.dart';
import 'package:get/get.dart';

class BackFillingWsViewModel extends GetxController {

  var allWsBackFilling = <BackFillingWsModel>[].obs;
  BackFillingWsRepository backFillingWsRepository = BackFillingWsRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllWsBackFilling() async{
    var wsBackFilling = await backFillingWsRepository.getBackFillingWs();
    allWsBackFilling.value = wsBackFilling;

  }

  addWsBackFilling(BackFillingWsModel backFillingWsModel){
    backFillingWsRepository.add(backFillingWsModel);

  }

  updateWsBackFilling(BackFillingWsModel backFillingWsModel){
    backFillingWsRepository.update(backFillingWsModel);
    fetchAllWsBackFilling();
  }

  deleteWsBackFilling(int id){
    backFillingWsRepository.delete(id);
    fetchAllWsBackFilling();
  }

}

