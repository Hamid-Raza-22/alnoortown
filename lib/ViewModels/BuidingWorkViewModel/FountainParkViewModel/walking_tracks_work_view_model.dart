
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/walking_tracks_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/walking_tracks_work_repository.dart';
import 'package:get/get.dart';

class WalkingTracksWorkViewModel extends GetxController {

  var allWalking = <WalkingTracksWorkModel>[].obs;
  WalkingTracksWorkRepository walkingTracksWorkRepository = WalkingTracksWorkRepository();

  @override
  void onInit(){

    super.onInit();
  //   //fetchAllWalking();
  //
  }

  fetchAllWalking() async{
    var walking = await walkingTracksWorkRepository.getWalkingTracksWork();
    allWalking.value = walking;

  }

  addWalking(WalkingTracksWorkModel walkingTracksWorkModel){
    walkingTracksWorkRepository.add(walkingTracksWorkModel);

  }

  updateWalking(WalkingTracksWorkModel walkingTracksWorkModel){
    walkingTracksWorkRepository.update(walkingTracksWorkModel);
    fetchAllWalking();
  }

  deleteWalking(int id){
    walkingTracksWorkRepository.delete(id);
    fetchAllWalking();
  }

}

