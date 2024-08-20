import 'package:get/get.dart';

import '../../../Models/DevelopmentsWorksModels/LightPolesWorkModels/light_wires_model.dart';
import '../../../Repositories/DevelopmentsWorksRepositories/LightPolesWorkRepositories/light_wires_repository.dart';



class LightWiresViewModel extends GetxController {

  var allLight = <LightWiresModel>[].obs;
  LightWiresRepository lightWiresRepository = LightWiresRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllLight();
  }

  fetchAllLight() async{
    var light = await lightWiresRepository.getLightWires();
    allLight.value = light;

  }

  addLight(LightWiresModel lightWiresModel){
    lightWiresRepository.add(lightWiresModel);
    //fetchAllLight();
  }

  updateLight(LightWiresModel lightWiresModel){
    lightWiresRepository.update(lightWiresModel);
    fetchAllLight();
  }

  deleteLight(int id){
    lightWiresRepository.delete(id);
    fetchAllLight();
  }

}

