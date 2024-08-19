
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/brick_work_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/brick_work_repository.dart';
import 'package:get/get.dart';

class BrickWorkViewModel extends GetxController {

  var allBrick = <BrickWorkModel>[].obs;
  BrickWorkRepository brickWorkRepository = BrickWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllBrick();
  }

  fetchAllBrick() async{
    var asphalts = await brickWorkRepository.getBrickWork();
    allBrick .value = asphalts;

  }

  addBrick(BrickWorkModel brickWorkModel){
    brickWorkRepository.add(brickWorkModel);
    fetchAllBrick();
  }

  updateBrick(BrickWorkModel brickWorkModel){
    brickWorkRepository.update(brickWorkModel);
    fetchAllBrick();
  }

  deleteBrick(int id){
    brickWorkRepository.delete(id);
    fetchAllBrick();
  }

}

