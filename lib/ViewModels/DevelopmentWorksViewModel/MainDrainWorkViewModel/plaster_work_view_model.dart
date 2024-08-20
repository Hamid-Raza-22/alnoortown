
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/plaster_work_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/plaster_work_repository.dart';
import 'package:get/get.dart';

class PlasterWorkViewModel extends GetxController {

  var allPlaster = <PlasterWorkModel>[].obs;
  PlasterWorkRepository plasterWorkRepository = PlasterWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
   // fetchAllPlaster ();
  }

  fetchAllPlaster() async{
    var work = await plasterWorkRepository.getPlasterWork();
    allPlaster .value = work;

  }

  addMan(PlasterWorkModel plasterWorkModel){
    plasterWorkRepository.add(plasterWorkModel);
   // fetchAllPlaster();
  }

  updateMan(PlasterWorkModel plasterWorkModel){
    plasterWorkRepository.update(plasterWorkModel);
    fetchAllPlaster();
  }

  deleteMan(int id){
    plasterWorkRepository.delete(id);
    fetchAllPlaster();
  }

}

