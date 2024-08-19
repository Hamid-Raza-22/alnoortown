
import 'package:al_noor_town/Models/NewMaterialModels/new_material_model.dart';
import 'package:al_noor_town/Repositories/NewMaterialRepositories/new_material_repository.dart';
import 'package:get/get.dart';

class NewMaterialViewModel extends GetxController {

  var allNew = <NewMaterialModel>[].obs;
  NewMaterialRepository newMaterialRepository = NewMaterialRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllNew ();
  }

  fetchAllNew() async{
    var material = await newMaterialRepository.getNewMaterial();
    allNew .value = material;

  }

  addNew(NewMaterialModel newMaterialModel){
    newMaterialRepository.add(newMaterialModel);
    //fetchAllNew();
  }

  updateNew(NewMaterialModel newMaterialModel){
    newMaterialRepository.update(newMaterialModel);
    fetchAllNew();
  }

  deleteNew(int id){
    newMaterialRepository.delete(id);
    fetchAllNew();
  }

}

