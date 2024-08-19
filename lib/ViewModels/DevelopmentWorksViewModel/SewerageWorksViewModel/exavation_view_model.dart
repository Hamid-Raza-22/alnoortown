
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/exavation_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/SewerageWorksRepositries/exavation_repository.dart';
import 'package:get/get.dart';

class ExavationViewModel extends GetxController {

  var allExa = <ExavationModel>[].obs;
  ExavationRepository exavationRepository = ExavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllExa ();
  }

  fetchAllExa() async{
    var exavation = await exavationRepository.getExavation();
    allExa .value = exavation;

  }

  addExa(ExavationModel exavationModel){
    exavationRepository.add(exavationModel);
    fetchAllExa();
  }

  updateExa(ExavationModel exavationModel){
    exavationRepository.update(exavationModel);
    fetchAllExa();
  }

  deleteExa(int id){
    exavationRepository.delete(id);
    fetchAllExa();
  }

}

