
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/main_drain_exavation_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/main_drain_exavation_repository.dart';
import 'package:get/get.dart';

class MainDrainExavationViewModel extends GetxController {

  var allDrain = <MainDrainExavationModel>[].obs;
  MainDrainExavationRepository mainDrainExavationRepository = MainDrainExavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllDrain();
  }

  fetchAllDrain() async{
    var main = await mainDrainExavationRepository.getMainDrainExavation();
    allDrain .value = main;

  }

  addWork(MainDrainExavationModel mainDrainExavationModel){
    mainDrainExavationRepository.add(mainDrainExavationModel);
    fetchAllDrain();
  }

  updateWork(MainDrainExavationModel mainDrainExavationModel){
    mainDrainExavationRepository.update(mainDrainExavationModel);
    fetchAllDrain();
  }

  deleteWork(int id){
    mainDrainExavationRepository.delete(id);
    fetchAllDrain();
  }

}

