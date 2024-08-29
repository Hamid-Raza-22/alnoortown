
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/main_gate_foundation_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/TownMainGatesRepositorty/main_gate_foundation_work_repository.dart';
import 'package:get/get.dart';

class MainGateFoundationWorkViewModel extends GetxController {

  var allMainFoundation = <MainGateFoundationWorkModel>[].obs;
  MainGateFoundationWorkRepository mainGateFoundationWorkRepository = MainGateFoundationWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllMainFoundation() async{
    var mainFoundation = await mainGateFoundationWorkRepository.getMainGateFoundationWork();
    allMainFoundation.value = mainFoundation;

  }

  addMainFoundation(MainGateFoundationWorkModel mainGateFoundationWorkModel){
    mainGateFoundationWorkRepository.add(mainGateFoundationWorkModel);

  }

  updateMainFoundation(MainGateFoundationWorkModel mainGateFoundationWorkModel){
    mainGateFoundationWorkRepository.update(mainGateFoundationWorkModel);
    fetchAllMainFoundation();
  }

  deleteMainFoundation(int id){
    mainGateFoundationWorkRepository.delete(id);
    fetchAllMainFoundation();
  }

}

