
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/filing_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/SewerageWorksRepositries/filling_repository.dart';
import 'package:get/get.dart';

class FillingViewModel extends GetxController {

  var allFill = <FilingModel>[].obs;
  FillingRepository fillingRepository = FillingRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllFill ();
  }

  fetchAllFill() async{
    var filling = await fillingRepository.getFiling();
    allFill .value = filling;

  }

  addFill(FilingModel filingModel){
    fillingRepository.add(filingModel);
    fetchAllFill();
  }

  updateFill(FilingModel filingModel){
    fillingRepository.update(filingModel);
    fetchAllFill();
  }

  deleteFill(int id){
    fillingRepository.delete(id);
    fetchAllFill();
  }

}

