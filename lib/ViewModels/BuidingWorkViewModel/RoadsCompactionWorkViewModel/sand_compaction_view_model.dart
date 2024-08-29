
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/sand_compaction_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsCompactionWorkRepository/sand_compaction_repository.dart';
import 'package:get/get.dart';

class SandCompactionViewModel extends GetxController {

  var allSand = <SandCompactionModel>[].obs;
  SandCompactionRepository sandCompactionRepository = SandCompactionRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllSand() async{
    var sand = await sandCompactionRepository.getSandCompaction();
    allSand.value = sand;

  }

  addSand(SandCompactionModel sandCompactionModel){
    sandCompactionRepository.add(sandCompactionModel);

  }

  updateSand(SandCompactionModel sandCompactionModel){
    sandCompactionRepository.update(sandCompactionModel);
    fetchAllSand();
  }

  deleteSand(int id){
    sandCompactionRepository.delete(id);
    fetchAllSand();
  }

}

