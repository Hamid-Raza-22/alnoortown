import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/mosque_excavation_work.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/mosque_exavation_repository.dart';
import 'package:get/get.dart';

class MosqueExcavationViewModel extends GetxController {

  var allMosque = <MosqueExcavationWorkModel>[].obs;
  MosqueExcavationRepository mosqueExcavationRepository = MosqueExcavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    // fetchAllMosque();
  }

  fetchAllMosque() async{
    var mosques = await mosqueExcavationRepository.getMosqueExcavation();
    allMosque.value = mosques;

  }

  addMosque(MosqueExcavationWorkModel mosqueExcavationWorkModel){
    mosqueExcavationRepository.add(mosqueExcavationWorkModel);
    //fetchAllMosque();
  }

  updateMosque(MosqueExcavationWorkModel mosqueExcavationWorkModel){
    mosqueExcavationRepository.update(mosqueExcavationWorkModel);
    fetchAllMosque();
  }

  deleteLight(int id){
    mosqueExcavationRepository.delete(id);
    fetchAllMosque();
  }

}

