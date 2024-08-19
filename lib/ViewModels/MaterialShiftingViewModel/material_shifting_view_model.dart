
import 'package:al_noor_town/Models/MaterialShiftingModels/shifting_work_model.dart';
import 'package:al_noor_town/Repositories/MaterialShiftingRepositories/shifting_work_repository.dart';
import 'package:get/get.dart';

class MaterialShiftingViewModel extends GetxController {

  var allShifting = <ShiftingWorkModel>[].obs;
  ShiftingWorkRepository shiftingWorkRepository = ShiftingWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllShifting ();
  }

  fetchAllShifting() async{
    var shift = await shiftingWorkRepository.getShiftingWork();
    allShifting .value = shift;

  }

  addShift(ShiftingWorkModel shiftingWorkModel){
    shiftingWorkRepository.add(shiftingWorkModel);
    //fetchAllShifting();
  }

  updateShift(ShiftingWorkModel shiftingWorkModel){
    shiftingWorkRepository.update(shiftingWorkModel);
    fetchAllShifting();
  }

  deleteShift(int id){
    shiftingWorkRepository.delete(id);
    fetchAllShifting();
  }

}

