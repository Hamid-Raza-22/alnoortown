
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/brick_work_model.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/iron_works_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/brick_work_repository.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/iron_works_repository.dart';
import 'package:get/get.dart';

class IronWorkViewModel extends GetxController {

  var allWorks = <IronWorksModel>[].obs;
  IronWorksRepository ironWorksRepository = IronWorksRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllWorks();
  }

  fetchAllWorks() async{
    var iron = await ironWorksRepository.getIronWorks();
    allWorks .value = iron;

  }

  addWorks(IronWorksModel ironWorksModel){
    ironWorksRepository.add(ironWorksModel);
    fetchAllWorks();
  }

  updateWorks(IronWorksModel ironWorksModel){
    ironWorksRepository.update(ironWorksModel);
    fetchAllWorks();
  }

  deleteWorks(int id){
    ironWorksRepository.delete(id);
    fetchAllWorks();
  }

}

