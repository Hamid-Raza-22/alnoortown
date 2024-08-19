import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_exavation_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/LightPolesWorkRepositories/poles_exavation_repository.dart';
import 'package:get/get.dart';

class PolesExavationViewModel extends GetxController {

  var allPoleExa = <PolesExavationModel>[].obs;
  PolesExavationRepository polesExavationRepository = PolesExavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllPoleExa();
  }

  fetchAllPoleExa() async{
    var poles = await polesExavationRepository.getPolesExavation();
    allPoleExa .value = poles;

  }

  addPoleExa(PolesExavationModel polesExavationModel){
    polesExavationRepository.add(polesExavationModel);
    //fetchAllPoleExa();
  }

  updatePoleExa(PolesExavationModel polesExavationModel){
    polesExavationRepository.update(polesExavationModel);
    fetchAllPoleExa();
  }

  deletePoleExa(int id){
    polesExavationRepository.delete(id);
    fetchAllPoleExa();
  }

}

