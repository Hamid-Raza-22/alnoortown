
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/electricity_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/electricity_work_repository.dart';
import 'package:get/get.dart';

class ElectricityWorkViewModel extends GetxController {

  var allElectricity = <ElectricityWorkModel>[].obs;
  ElectricityWorkRepository electricityWorkRepository = ElectricityWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllElectricity() async{
    var electricity = await electricityWorkRepository.getElectricityWork();
    allElectricity.value = electricity;

  }

  addElectricity(ElectricityWorkModel electricityWorkModel){
    electricityWorkRepository.add(electricityWorkModel);

  }

  updateElectricity(ElectricityWorkModel electricityWorkModel){
    electricityWorkRepository.update(electricityWorkModel);
    fetchAllElectricity();
  }

  deleteElectricity(int id){
    electricityWorkRepository.delete(id);
    fetchAllElectricity();
  }

}

