
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/main_drain_excavation_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/main_drain_excavation_repository.dart';
import 'package:get/get.dart';

class MainDrainExcavationViewModel extends GetxController {

  var allDrain = <MainDrainExcavationModel>[].obs;
  MainDrainExcavationRepository mainDrainExcavationRepository = MainDrainExcavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllDrain();
  }

  fetchAllDrain() async{
    var main = await mainDrainExcavationRepository.getMainDrainExcavation();
    allDrain .value = main;

  }

  addWork(MainDrainExcavationModel mainDrainExcavationModel){
    mainDrainExcavationRepository.add(mainDrainExcavationModel);
    //fetchAllDrain();
  }

  updateWork(MainDrainExcavationModel mainDrainExcavationModel){
    mainDrainExcavationRepository.update(mainDrainExcavationModel);
    fetchAllDrain();
  }

  deleteWork(int id){
    mainDrainExcavationRepository.delete(id);
    fetchAllDrain();
  }

}

