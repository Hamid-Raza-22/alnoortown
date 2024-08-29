
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/compaction_water_bound_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsCompactionWorkRepository/compaction_water_bound_repository.dart';
import 'package:get/get.dart';

class CompactionWaterBoundViewModel extends GetxController {

  var allWaterBound = <CompactionWaterBoundModel>[].obs;
  CompactionWaterBoundRepository compactionWaterBoundRepository = CompactionWaterBoundRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllWaterBound() async{
    var waterBound = await compactionWaterBoundRepository.getCompactionWaterBound();
    allWaterBound.value = waterBound;

  }

  addWaterBound(CompactionWaterBoundModel compactionWaterBoundModel){
    compactionWaterBoundRepository.add(compactionWaterBoundModel);

  }

  updateWaterBound(CompactionWaterBoundModel compactionWaterBoundModel){
    compactionWaterBoundRepository.update(compactionWaterBoundModel);
    fetchAllWaterBound();
  }

  deleteWaterBound(int id){
    compactionWaterBoundRepository.delete(id);
    fetchAllWaterBound();
  }

}

