
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/tiles_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/tiles_work_repository.dart';
import 'package:get/get.dart';

class TilesWorkViewModel extends GetxController {

  var allTiles = <TilesWorkModel>[].obs;
  TilesWorkRepository tilesWorkRepository = TilesWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllTiles() async{
    var tilesJob = await tilesWorkRepository.getTilesWork();
    allTiles.value = tilesJob;

  }

  addTiles(TilesWorkModel tilesWorkModel){
    tilesWorkRepository.add(tilesWorkModel);

  }

  updateTiles(TilesWorkModel tilesWorkModel){
    tilesWorkRepository.update(tilesWorkModel);
    fetchAllTiles();
  }

  deleteTiles(int id){
    tilesWorkRepository.delete(id);
    fetchAllTiles();
  }

}

