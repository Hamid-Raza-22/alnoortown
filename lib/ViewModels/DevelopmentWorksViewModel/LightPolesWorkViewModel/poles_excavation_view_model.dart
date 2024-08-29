import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_excavation_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/LightPolesWorkRepositories/poles_excavation_repository.dart';
import 'package:get/get.dart';

class PolesExcavationViewModel extends GetxController {

  var allPoleExa = <PolesExcavationModel>[].obs;
  PolesExcavationRepository polesExcavationRepository = PolesExcavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllPoleExa();
  }

  fetchAllPoleExa() async{
    var poles = await polesExcavationRepository.getPolesExcavation();
    allPoleExa .value = poles;

  }

  addPoleExa(PolesExcavationModel polesExcavationModel){
    polesExcavationRepository.add(polesExcavationModel);
    //fetchAllPoleExa();
  }

  updatePoleExa(PolesExcavationModel polesExcavationModel){
    polesExcavationRepository.update(polesExcavationModel);
    fetchAllPoleExa();
  }

  deletePoleExa(int id){
    polesExcavationRepository.delete(id);
    fetchAllPoleExa();
  }

}

