
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/first_floor_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/first_floor_repository.dart';
import 'package:get/get.dart';

class FirstFloorViewModel extends GetxController {

  var allFirstFloor = <FirstFloorModel>[].obs;
  FirstFloorRepository firstFloorRepository = FirstFloorRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllFirstFloor() async{
    var firstFloor = await firstFloorRepository.getFirstFloor();
    allFirstFloor.value = firstFloor;

  }

  addFirstFloor(FirstFloorModel firstFloorModel){
    firstFloorRepository.add(firstFloorModel);

  }

  updateFirstFloor(FirstFloorModel firstFloorModel){
    firstFloorRepository.update(firstFloorModel);
    fetchAllFirstFloor();
  }

  deleteFirstFloor(int id){
    firstFloorRepository.delete(id);
    fetchAllFirstFloor();
  }

}

