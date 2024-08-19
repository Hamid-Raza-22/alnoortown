
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/manholes_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/SewerageWorksRepositries/manholes_repository.dart';
import 'package:get/get.dart';

class ManholesViewModel extends GetxController {

  var allWorker = <ManholesModel>[].obs;
  ManholesRepository manholesRepository = ManholesRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllWorker ();
  }

  fetchAllWorker() async{
    var slab = await manholesRepository.getManholes();
    allWorker .value = slab;

  }

  addWorker(ManholesModel manholesModel){
    manholesRepository.add(manholesModel);
    fetchAllWorker();
  }

  updateWorker(ManholesModel manholesModel){
    manholesRepository.update(manholesModel);
    fetchAllWorker();
  }

  deleteWorker(int id){
    manholesRepository.delete(id);
    fetchAllWorker();
  }

}

