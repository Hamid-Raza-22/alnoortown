
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/doors_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/door_work_repository.dart';
import 'package:get/get.dart';

class DoorWorkViewModel extends GetxController {

  var allDoor = <DoorsWorkModel>[].obs;
  DoorWorkRepository doorWorkRepository = DoorWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllDoor() async{
    var door = await doorWorkRepository.getDoorWork();
    allDoor.value = door;

  }

  addDoor(DoorsWorkModel doorsWorkModel){
    doorWorkRepository.add(doorsWorkModel);

  }

  updateDoor(DoorsWorkModel doorsWorkModel){
    doorWorkRepository.update(doorsWorkModel);
    fetchAllDoor();
  }

  deleteDoor(int id){
    doorWorkRepository.delete(id);
    fetchAllDoor();
  }

}

