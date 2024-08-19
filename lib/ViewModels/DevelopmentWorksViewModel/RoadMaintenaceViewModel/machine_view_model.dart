
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/machine_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/RoadMaintenaceRepositories/machine_repository.dart';
import 'package:get/get.dart';

class MachineViewModel extends GetxController {

  var allMachine = <MachineModel>[].obs;
  MachineRepository machineRepository = MachineRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
   // fetchAllMachine ();
  }

  fetchAllMachine() async{
    var machine = await machineRepository.getMachine();
    allMachine .value = machine;
  }

  addMachine(MachineModel machineModel){
    machineRepository.add(machineModel);
   // fetchAllMachine();
  }

  updateMachine(MachineModel machineModel){
    machineRepository.update(machineModel);
    fetchAllMachine();
  }

  deleteMachine(int? id){
    machineRepository.delete(id);
    fetchAllMachine();
  }

}

