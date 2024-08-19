
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/LightPolesWorkRepositories/poles_repository.dart';
import 'package:get/get.dart';

class PolesViewModel extends GetxController {

  var allPole = <PolesModel>[].obs;
  PolesRepository polesRepository = PolesRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
   // fetchAllPole();
  }

  fetchAllPole() async{
    var poles = await polesRepository.getPoles();
    allPole .value = poles;

  }

  addPole(PolesModel polesModel){
    polesRepository.add(polesModel);
    //fetchAllPole();
  }

  updatePole(PolesModel polesModel){
    polesRepository.update(polesModel);
    fetchAllPole();
  }

  deletePole(int id){
    polesRepository.delete(id);
    fetchAllPole();
  }

}

