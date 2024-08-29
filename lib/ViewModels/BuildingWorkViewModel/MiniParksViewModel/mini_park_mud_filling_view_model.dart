
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mini_park_mud_filling_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/mini_park_mud_filling_repository.dart';
import 'package:get/get.dart';

class MiniParkMudFillingViewModel extends GetxController {

  var allMpMud = <MiniParkMudFillingModel>[].obs;
  MiniParkMudFillingRepository miniParkMudFillingRepository = MiniParkMudFillingRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllMpMud() async{
    var mpMud = await miniParkMudFillingRepository.getMiniParkMudFilling();
    allMpMud.value = mpMud;

  }

  addMpMud(MiniParkMudFillingModel miniParkMudFillingModel){
    miniParkMudFillingRepository.add(miniParkMudFillingModel);

  }

  updateMpMud(MiniParkMudFillingModel miniParkMudFillingModel){
    miniParkMudFillingRepository.update(miniParkMudFillingModel);
    fetchAllMpMud();
  }

  deleteMpMud(int id){
    miniParkMudFillingRepository.delete(id);
    fetchAllMpMud();
  }

}

