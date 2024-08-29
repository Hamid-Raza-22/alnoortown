
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/foundation_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/foundation_work_repository.dart';
import 'package:get/get.dart';

class FoundationWorkViewModel extends GetxController {

  var allFoundation = <FoundationWorkModel>[].obs;
  FoundationWorkRepository foundationWorkRepository = FoundationWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllFoundation() async{
    var foundation = await foundationWorkRepository.getFoundationWork();
    allFoundation.value = foundation;

  }

  addFoundation(FoundationWorkModel foundationWorkModel){
    foundationWorkRepository.add(foundationWorkModel);

  }

  updateFoundation(FoundationWorkModel foundationWorkModel){
    foundationWorkRepository.update(foundationWorkModel);
    fetchAllFoundation();
  }

  deleteFoundation(int id){
    foundationWorkRepository.delete(id);
    fetchAllFoundation();
  }

}

