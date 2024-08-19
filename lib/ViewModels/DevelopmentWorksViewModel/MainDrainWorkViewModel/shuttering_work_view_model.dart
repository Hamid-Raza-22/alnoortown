
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/shuttering_work_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/shuttering_work_repository.dart';
import 'package:get/get.dart';

class ShutteringWorkViewModel extends GetxController {

  var allShutter = <ShutteringWorkModel>[].obs;
  ShutteringWorkRepository shutteringWorkRepository = ShutteringWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllShutter ();
  }

  fetchAllShutter() async{
    var work = await shutteringWorkRepository.getShutteringWork();
    allShutter .value = work;

  }

  addShutter(ShutteringWorkModel shutteringWorkModel){
    shutteringWorkRepository.add(shutteringWorkModel);
    fetchAllShutter();
  }

  updateShutter(ShutteringWorkModel shutteringWorkModel){
    shutteringWorkRepository.update(shutteringWorkModel);
    fetchAllShutter();
  }

  deleteShutter(int id){
    shutteringWorkRepository.delete(id);
    fetchAllShutter();
  }

}

