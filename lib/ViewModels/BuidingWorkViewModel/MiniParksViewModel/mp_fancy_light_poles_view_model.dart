
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mp_fancy_light_poles_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/mp_fancy_light_poles_repository.dart';
import 'package:get/get.dart';

class MpFancyLightPolesViewModel extends GetxController {

  var allMpFancy = <MpFancyLightPolesModel>[].obs;
  MpFancyLightPolesRepository mpFancyLightPolesRepository = MpFancyLightPolesRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllMpFancy() async{
    var mpFancy = await mpFancyLightPolesRepository.getMpFancyLightPoles();
    allMpFancy.value = mpFancy;

  }

  addMpFancy(MpFancyLightPolesModel mpFancyLightPolesModel){
    mpFancyLightPolesRepository.add(mpFancyLightPolesModel);

  }

  updateMpFancy(MpFancyLightPolesModel mpFancyLightPolesModel){
    mpFancyLightPolesRepository.update(mpFancyLightPolesModel);
    fetchAllMpFancy();
  }

  deleteMpFancy(int id){
    mpFancyLightPolesRepository.delete(id);
    fetchAllMpFancy();
  }

}

