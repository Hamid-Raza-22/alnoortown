import 'package:al_noor_town/Models/BuildingWorkModels/mosque_exavation_work.dart';
import 'package:al_noor_town/Repositories/BuidingWorkRepsitories/mosque_exavation_repository.dart';
import 'package:get/get.dart';




class MosqueExavationViewMode extends GetxController {

  var allMosque = <MosqueExavationWorkModel>[].obs;
  MosqueExavationRepository mosqueExavationRepository = MosqueExavationRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllMosque();
  }

  fetchAllMosque() async{
    var mosques = await mosqueExavationRepository.getMosqueExavation();
    allMosque.value = mosques;

  }

  addLight(MosqueExavationWorkModel mosqueExavationWorkModel){
    mosqueExavationRepository.add(mosqueExavationWorkModel);
    fetchAllMosque();
  }

  updateLight(MosqueExavationWorkModel mosqueExavationWorkModel){
    mosqueExavationRepository.update(mosqueExavationWorkModel);
    fetchAllMosque();
  }

  deleteLight(int id){
    mosqueExavationRepository.delete(id);
    fetchAllMosque()();
  }

}

