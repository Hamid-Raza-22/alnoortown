
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/canopy_column_pouring_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/TownMainGatesRepository/canopy_column_pouring_repository.dart';
import 'package:get/get.dart';

class CanopyColumnPouringViewModel extends GetxController {

  var allCanopy = <CanopyColumnPouringModel>[].obs;
  CanopyColumnPouringRepository canopyColumnPouringRepository = CanopyColumnPouringRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllCanopy() async{
    var canopy = await canopyColumnPouringRepository.getCanopyColumnPouring();
    allCanopy.value = canopy;

  }

  addCanopy(CanopyColumnPouringModel canopyColumnPouringModel){
    canopyColumnPouringRepository.add(canopyColumnPouringModel);

  }

  updateCanopy(CanopyColumnPouringModel canopyColumnPouringModel){
    canopyColumnPouringRepository.update(canopyColumnPouringModel);
    fetchAllCanopy();
  }

  deleteCanopy(int id){
    canopyColumnPouringRepository.delete(id);
    fetchAllCanopy();
  }

}

