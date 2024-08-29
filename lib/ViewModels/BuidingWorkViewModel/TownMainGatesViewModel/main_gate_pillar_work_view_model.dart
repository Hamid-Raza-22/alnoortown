
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/main_gate_pillar_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/TownMainGatesRepositorty/main_gate_pillar_work_repository.dart';
import 'package:get/get.dart';

class MainGatePillarWorkViewModel extends GetxController {

  var allMainPillar = <MainGatePillarWorkModel>[].obs;
  MainGatePillarWorkRepository mainGatePillarWorkRepository = MainGatePillarWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllMainPillar() async{
    var mainPillar = await mainGatePillarWorkRepository.getMainGatePillarWork();
    allMainPillar.value = mainPillar;

  }

  addMainPillar(MainGatePillarWorkModel mainGatePillarWorkModel){
    mainGatePillarWorkRepository.add(mainGatePillarWorkModel);

  }

  updateMainPillar(MainGatePillarWorkModel mainGatePillarWorkModel){
    mainGatePillarWorkRepository.update(mainGatePillarWorkModel);
    fetchAllMainPillar();
  }

  deleteMainPillar(int id){
    mainGatePillarWorkRepository.delete(id);
    fetchAllMainPillar();
  }

}

