
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/mg_grey_structure_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/TownMainGatesRepository/mg_grey_structure_repository.dart';
import 'package:get/get.dart';

class MgGreyStructureViewModel extends GetxController {

  var allMainGrey = <MgGreyStructureModel>[].obs;
  MgGreyStructureRepository mgGreyStructureRepository = MgGreyStructureRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllMainGrey() async{
    var mainGrey = await mgGreyStructureRepository.getMgGreyStructure();
    allMainGrey.value = mainGrey;

  }

  addMainGrey(MgGreyStructureModel mgGreyStructureModel){
    mgGreyStructureRepository.add(mgGreyStructureModel);

  }

  updateMainGrey(MgGreyStructureModel mgGreyStructureModel){
    mgGreyStructureRepository.update(mgGreyStructureModel);
    fetchAllMainGrey();
  }

  deleteMainGrey(int id){
    mgGreyStructureRepository.delete(id);
    fetchAllMainGrey();
  }

}

