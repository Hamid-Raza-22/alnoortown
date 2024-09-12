
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/back_filing_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/SewerageWorksRepositries/back_filling_repository.dart';
import 'package:get/get.dart';

class BackFillingViewModel extends GetxController {

  var allFill = <BackFilingModel>[].obs;
  BackFillingRepository backFillingRepository = BackFillingRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllFill ();
  }

  fetchAllFill() async{
    var filling = await backFillingRepository.getFiling();
    allFill .value = filling;

  }

  addFill(BackFilingModel filingModel){
    backFillingRepository.add(filingModel);
    //fetchAllFill();
  }

  updateFill(BackFilingModel filingModel){
    backFillingRepository.update(filingModel);
    fetchAllFill();
  }

  deleteFill(int id){
    backFillingRepository.delete(id);
    fetchAllFill();
  }

}

