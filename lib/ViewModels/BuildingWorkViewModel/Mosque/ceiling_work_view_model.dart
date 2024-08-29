import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/ceiling_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/ceiling_work_repository.dart';
import 'package:get/get.dart';

class CeilingWorkViewModel extends GetxController {

  var allCeiling = <CeilingWorkModel>[].obs;
  CeilingWorkRepository ceilingWorkRepository = CeilingWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllCeiling() async{
    var ceiling = await ceilingWorkRepository.getCeilingWork();
    allCeiling.value = ceiling;

  }

  addCeiling(CeilingWorkModel ceilingWorkModel){
    ceilingWorkRepository.add(ceilingWorkModel);

  }

  updateCeiling(CeilingWorkModel ceilingWorkModel){
    ceilingWorkRepository.update(ceilingWorkModel);
    fetchAllCeiling();
  }

  deleteCeiling(int id){
    ceilingWorkRepository.delete(id);
    fetchAllCeiling();
  }

}

