
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/mini_park_curb_stone_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/mini_park_curb_stone_repository.dart';
import 'package:get/get.dart';

class MiniParkCurbStoneViewModel extends GetxController {

  var allMpCurb = <MiniParkCurbStoneModel>[].obs;
  MiniParkCurbStoneRepository miniParkCurbStoneRepository = MiniParkCurbStoneRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllMpCurb() async{
    var mpCurb = await miniParkCurbStoneRepository.getMiniParkCurbStone();
    allMpCurb.value = mpCurb;

  }

  addMpCurb(MiniParkCurbStoneModel miniParkCurbStoneModel){
    miniParkCurbStoneRepository.add(miniParkCurbStoneModel);

  }

  updateMpCurb(MiniParkCurbStoneModel miniParkCurbStoneModel){
    miniParkCurbStoneRepository.update(miniParkCurbStoneModel);
    fetchAllMpCurb();
  }

  deleteMpCurb(int id){
    miniParkCurbStoneRepository.delete(id);
    fetchAllMpCurb();
  }

}

