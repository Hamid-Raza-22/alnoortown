import 'package:al_noor_town/Models/BuildingWorkModels/FountainParkModel/boundary_grill_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/FountainParkRepository/boundary_grill_work_repository.dart';
import 'package:get/get.dart';

class BoundaryGrillWorkViewModel extends GetxController {

  var allBoundary = <BoundaryGrillWorkModel>[].obs;
  BoundaryGrillWorkRepository boundaryGrillWorkRepository = BoundaryGrillWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllBoundary() async{
    var boundary = await boundaryGrillWorkRepository.getBoundaryGrillWork();
    allBoundary.value = boundary;

  }

  addBoundary(BoundaryGrillWorkModel boundaryGrillWorkModel){
    boundaryGrillWorkRepository.add(boundaryGrillWorkModel);

  }

  updateBoundary(BoundaryGrillWorkModel boundaryGrillWorkModel){
    boundaryGrillWorkRepository.update(boundaryGrillWorkModel);
    fetchAllBoundary();
  }

  deleteBoundary(int id){
    boundaryGrillWorkRepository.delete(id);
    fetchAllBoundary();
  }

}

