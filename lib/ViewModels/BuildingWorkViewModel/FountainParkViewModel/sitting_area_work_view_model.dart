
import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/sitting_area_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/sitting_area_work_repository.dart';
import 'package:get/get.dart';

class SittingAreaWorkViewModel extends GetxController {

  var allSitting = <SittingAreaWorkModel>[].obs;
  SittingAreaWorkRepository sittingAreaWorkRepository = SittingAreaWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllSitting() async{
    var sitting = await sittingAreaWorkRepository.getSittingAreaWork();
    allSitting.value = sitting;

  }

  addSitting(SittingAreaWorkModel sittingAreaWorkModel){
    sittingAreaWorkRepository.add(sittingAreaWorkModel);

  }

  updateSitting(SittingAreaWorkModel sittingAreaWorkModel){
    sittingAreaWorkRepository.update(sittingAreaWorkModel);
    fetchAllSitting();
  }

  deleteSitting(int id){
    sittingAreaWorkRepository.delete(id);
    fetchAllSitting();
  }

}

