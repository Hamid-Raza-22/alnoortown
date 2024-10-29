import 'package:al_noor_town/Models/BlocksDetailsModels/blocks_details_models.dart';
import 'package:al_noor_town/Repositories/BlockDetailsRepositories/block_details_repository.dart';
import 'package:get/get.dart';
class BlockDetailsViewModel extends GetxController {

  var allBlockDetails = <BlocksDetailsModels>[].obs;
  var filteredPlots = <String>[].obs; // Observable list for filtered plots
  BlockDetailsRepository blockDetailsRepository = BlockDetailsRepository();
  var selectedFromPlot = ''.obs; // Selected value for from plot
  var selectedToPlot = ''.obs; // Selected value for to plot
  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllBlockDetails();
    //fetchAllLight();
  }
  void filterPlotsByBlock(String selectedBlock) {
    filteredPlots.value = allBlockDetails
        .where((detail) => detail.block == selectedBlock)
        .map((detail) => detail.plot_no.toString())
        .toList();
  }
  fetchAllBlockDetails() async{
    var blockDetails = await blockDetailsRepository.getBlockDetails();
    allBlockDetails.value = blockDetails;

  }
  fetchAndSaveBlockDetailsData() async {
    await blockDetailsRepository.fetchAndSaveBlockDetails();
    fetchAllBlockDetails();
  }
  addBlockDetails(BlocksDetailsModels blocksDetailsModels){
    blockDetailsRepository.add(blocksDetailsModels);
    //fetchAllLight();
  }

  updateBlockDetails(BlocksDetailsModels blocksDetailsModels){
    blockDetailsRepository.update(blocksDetailsModels);
    fetchAllBlockDetails();
  }

  deleteBlockDetails(int id){
    blockDetailsRepository.delete(id);
    fetchAllBlockDetails();
  }

}

