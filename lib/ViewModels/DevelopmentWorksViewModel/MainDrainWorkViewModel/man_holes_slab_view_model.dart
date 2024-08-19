
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/manholes_slab_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/manholes_slab_repository.dart';
import 'package:get/get.dart';

class ManHolesSlabViewModel extends GetxController {

  var allMan = <ManholesSlabModel>[].obs;
  ManholesSlabRepository manholesSlabRepository = ManholesSlabRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllMan ();
  }

  fetchAllMan() async{
    var holes = await manholesSlabRepository.getManHolesSlab();
    allMan .value = holes;

  }

  addMan(ManholesSlabModel manholesSlabModel){
    manholesSlabRepository.add(manholesSlabModel);
    //fetchAllMan();
  }

  updateMan(ManholesSlabModel manholesSlabModel){
    manholesSlabRepository.update(manholesSlabModel);
    fetchAllMan();
  }

  deleteMan(int id){
    manholesSlabRepository.delete(id);
    fetchAllMan();
  }

}

