
import 'package:al_noor_town/Models/BuildingWorkModels/MiniParksModel/monuments_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MiniParksRepository/monuments_work_repository.dart';
import 'package:get/get.dart';

class MonumentsWorkViewModel extends GetxController {

  var allMonument = <MonumentsWorkModel>[].obs;
  MonumentsWorkRepository monumentsWorkRepository = MonumentsWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllMonument() async{
    var monument = await monumentsWorkRepository.getMonumentsWork();
    allMonument.value = monument;

  }

  addMonument(MonumentsWorkModel monumentsWorkModel){
    monumentsWorkRepository.add(monumentsWorkModel);

  }

  updateMonument(MonumentsWorkModel monumentsWorkModel){
    monumentsWorkRepository.update(monumentsWorkModel);
    fetchAllMonument();
  }

  deleteMonument(int id){
    monumentsWorkRepository.delete(id);
    fetchAllMonument();
  }

}

