
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/mud_filling_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/mud_filling_work_repository.dart';
import 'package:get/get.dart';

class MudFillingWorkViewModel extends GetxController {

  var allMud = <MudFillingWorkModel>[].obs;
  MudFillingWorkRepository mudFillingWorkRepository = MudFillingWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllMud() async{
    var mud = await mudFillingWorkRepository.getMudFillingWork();
    allMud.value = mud;

  }

  addMud(MudFillingWorkModel mudFillingWorkModel){
    mudFillingWorkRepository.add(mudFillingWorkModel);

  }

  updateMud(MudFillingWorkModel mudFillingWorkModel){
    mudFillingWorkRepository.update(mudFillingWorkModel);
    fetchAllMud();
  }

  deleteMud(int id){
    mudFillingWorkRepository.delete(id);
    fetchAllMud();
  }

}

