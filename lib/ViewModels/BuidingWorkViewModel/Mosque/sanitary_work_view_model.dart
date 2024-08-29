
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/sanitary_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/sanitary_work_repository.dart';
import 'package:get/get.dart';

class SanitaryWorkViewModel extends GetxController {

  var allSanitary = <SanitaryWorkModel>[].obs;
  SanitaryWorkRepository sanitaryWorkRepository = SanitaryWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllSanitary() async{
    var sanitaryJob = await sanitaryWorkRepository.getSanitaryWork();
    allSanitary.value = sanitaryJob;

  }

  addSanitary(SanitaryWorkModel sanitaryWorkModel){
    sanitaryWorkRepository.add(sanitaryWorkModel);

  }

  updateSanitary(SanitaryWorkModel sanitaryWorkModel){
    sanitaryWorkRepository.update(sanitaryWorkModel);
    fetchAllSanitary();
  }

  deleteSanitary(int id){
    sanitaryWorkRepository.delete(id);
    fetchAllSanitary();
  }

}

