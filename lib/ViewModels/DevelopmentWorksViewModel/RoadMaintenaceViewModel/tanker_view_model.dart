
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/tanker_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/RoadMaintenaceRepositories/tanker_repository.dart';
import 'package:get/get.dart';

class TankerViewModel extends GetxController {

  var allTanker = <TankerModel>[].obs;
  TankerRepository tankerRepository = TankerRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllTanker ();
  }

  fetchAllTanker() async{
    var tanker = await tankerRepository.getTanker();
    allTanker .value = tanker;

  }

  addTanker(TankerModel tankerModel){
    tankerRepository.add(tankerModel);
    //fetchAllTanker();
  }

  updateTanker(TankerModel tankerModel){
    tankerRepository.update(tankerModel);
    fetchAllTanker();
  }

  deleteTanker(int id){
    tankerRepository.delete(id);
    fetchAllTanker();
  }

}

