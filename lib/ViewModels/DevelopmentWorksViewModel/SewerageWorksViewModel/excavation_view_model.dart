
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/excavation_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/SewerageWorksRepositries/excavation_repository.dart';
import 'package:get/get.dart';

class ExcavationViewModel extends GetxController {

  var allExa = <ExcavationModel>[].obs;
  ExcavationRepository excavationRepository = ExcavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllExa ()
  }
  fetchAllExa() async{
    var excavation = await excavationRepository.getExcavation();
    allExa .value = excavation;

  }

  addExa(ExcavationModel excavationModel){
    excavationRepository.add(excavationModel);
    //fetchAllExa();
  }

  updateExa(ExcavationModel excavationModel){
    excavationRepository.update(excavationModel);
    fetchAllExa();
  }

  deleteExa(int id){
    excavationRepository.delete(id);
    fetchAllExa();
  }

}

