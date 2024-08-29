
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsSignBoardsModel/roads_sign_boards_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/RoadsSignBoardsRepository/roads_sign_boards_repository.dart';
import 'package:get/get.dart';

class RoadsSignBoardsViewModel extends GetxController {

  var allRoadsSignBoard = <RoadsSignBoardsModel>[].obs;
  RoadsSignBoardsRepository roadsSignBoardsRepository = RoadsSignBoardsRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllRoadsSignBoard() async{
    var roadsSignBoard = await roadsSignBoardsRepository.getRoadsSignBoards();
    allRoadsSignBoard.value = roadsSignBoard;

  }

  addRoadsSignBoard(RoadsSignBoardsModel roadsSignBoardsModel){
    roadsSignBoardsRepository.add(roadsSignBoardsModel);

  }

  updateRoadsSignBoard(RoadsSignBoardsModel roadsSignBoardsModel){
    roadsSignBoardsRepository.update(roadsSignBoardsModel);
    fetchAllRoadsSignBoard();
  }

  deleteRoadsSignBoard(int id){
    roadsSignBoardsRepository.delete(id);
    fetchAllRoadsSignBoard();
  }

}

