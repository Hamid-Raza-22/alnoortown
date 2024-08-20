
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/asphalt_work_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/asphalt_work_repository.dart';
import 'package:get/get.dart';

class AsphaltWorkViewModel extends GetxController {

  var allAsphalt = <AsphaltWorkModel>[].obs;
  AsphaltWorkRepository asphaltWorkRepository = AsphaltWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllAsphalt();
  }

  fetchAllAsphalt() async{
    var asphalts = await asphaltWorkRepository.getAsphaltWork();
    allAsphalt .value = asphalts;

  }

  addAsphalt(AsphaltWorkModel asphaltWorkModel){
    asphaltWorkRepository.add(asphaltWorkModel);
    //fetchAllAsphalt();
  }

  updateAsphalt(AsphaltWorkModel asphaltWorkModel){
    asphaltWorkRepository.update(asphaltWorkModel);
    fetchAllAsphalt();
  }

  deleteAsphalt(int id){
    asphaltWorkRepository.delete(id);
    fetchAllAsphalt();
  }

}

