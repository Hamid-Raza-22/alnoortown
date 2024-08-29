
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/mg_plaster_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/TownMainGatesRepositorty/mg_plaster_work_repository.dart';
import 'package:get/get.dart';

class MgPlasterWorkViewModel extends GetxController {

  var allMgPlaster = <MgPlasterWorkModel>[].obs;
  MgPlasterWorkRepository mgPlasterWorkRepository = MgPlasterWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllMgPlaster() async{
    var mgPlaster = await mgPlasterWorkRepository.getMgPlasterWork();
    allMgPlaster.value = mgPlaster;

  }

  addMgPlaster(MgPlasterWorkModel mgPlasterWorkModel){
    mgPlasterWorkRepository.add(mgPlasterWorkModel);

  }

  updateMgPlaster(MgPlasterWorkModel mgPlasterWorkModel){
    mgPlasterWorkRepository.update(mgPlasterWorkModel);
    fetchAllMgPlaster();
  }

  deleteMgPlaster(int id){
    mgPlasterWorkRepository.delete(id);
    fetchAllMgPlaster();
  }

}

