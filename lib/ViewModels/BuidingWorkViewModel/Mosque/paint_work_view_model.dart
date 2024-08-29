
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/paint_work_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/MosqueRepository/paint_work_repository,.dart';
import 'package:get/get.dart';

class PaintWorkViewModel extends GetxController {

  var allPaint = <PaintWorkModel>[].obs;
  PaintWorkRepository paintWorkRepository = PaintWorkRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllPaint() async{
    var paintJob = await paintWorkRepository.getPaintWork();
    allPaint.value = paintJob;

  }

  addPaint(PaintWorkModel paintWorkModel){
    paintWorkRepository.add(paintWorkModel);

  }

  updatePaint(PaintWorkModel paintWorkModel){
    paintWorkRepository.update(paintWorkModel);
    fetchAllPaint();
  }

  deletePaint(int id){
    paintWorkRepository.delete(id);
    fetchAllPaint();
  }

}

