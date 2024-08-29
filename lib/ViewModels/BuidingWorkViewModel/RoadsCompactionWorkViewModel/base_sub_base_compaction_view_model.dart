
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/base_sub_base_compaction_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsCompactionWorkRepository/base_sub_base_compaction_repository.dart';
import 'package:get/get.dart';

class BaseSubBaseCompactionViewModel extends GetxController {

  var allSubBase = <BaseSubBaseCompactionModel>[].obs;
  BaseSubBaseCompactionRepository baseSubBaseCompactionRepository = BaseSubBaseCompactionRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllSubBase() async{
    var subBase = await baseSubBaseCompactionRepository.getSubBaseCompaction();
    allSubBase.value = subBase;

  }

  addSubBase(BaseSubBaseCompactionModel baseSubBaseCompactionModel){
    baseSubBaseCompactionRepository.add(baseSubBaseCompactionModel);

  }

  updateSubBase(BaseSubBaseCompactionModel baseSubBaseCompactionModel){
    baseSubBaseCompactionRepository.update(baseSubBaseCompactionModel);
    fetchAllSubBase();
  }

  deleteSubBase(int id){
    baseSubBaseCompactionRepository.delete(id);
    fetchAllSubBase();
  }

}

