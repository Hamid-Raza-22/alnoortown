
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/pipeline_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/SewerageWorksRepositries/pipeline_repository.dart';
import 'package:get/get.dart';

class PipelineViewModel extends GetxController {

  var allPipe = <PipelineModel>[].obs;
  PipelineRepository pipelineRepository = PipelineRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllPipe ();
  }

  fetchAllPipe() async{
    var line = await pipelineRepository.getPipeline();
    allPipe .value = line;

  }

  addPipe(PipelineModel pipelineModel){
    pipelineRepository.add(pipelineModel);
    fetchAllPipe();
  }

  updatePipe(PipelineModel pipelineModel){
    pipelineRepository.update(pipelineModel);
    fetchAllPipe();
  }

  deletePipe(int id){
    pipelineRepository.delete(id);
    fetchAllPipe();
  }

}

