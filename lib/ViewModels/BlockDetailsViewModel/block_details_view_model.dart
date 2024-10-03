import 'package:al_noor_town/Models/BlocksDetailsModels/blocks_details_models.dart';
import 'package:al_noor_town/Repositories/BlockDetailsRepositories/block_details_repository.dart';
import 'package:get/get.dart';
class BlockDetailsViewModel extends GetxController {

  var allBlockDetails = <BlocksDetailsModels>[].obs;
  BlockDetailsRepository blockDetailsRepository = BlockDetailsRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    fetchAllBlockDetails();
    //fetchAllLight();
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

