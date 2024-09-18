import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/iron_works_model.dart';
import 'package:al_noor_town/Repositories/DevelopmentsWorksRepositories/MainDrainWorkRepositories/iron_works_repository.dart';
import 'package:get/get.dart';

class IronWorkViewModel extends GetxController {
  var allWorks = <IronWorksModel>[].obs;
  final IronWorksRepository ironWorksRepository = IronWorksRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllWorks(); // Initial fetch if needed
  }

  Future<void> fetchAllWorks({DateTime? fromDate, DateTime? toDate, String? block}) async {
    // Fetch all works from repository
    var allWorksList = await ironWorksRepository.getIronWorks();

    // Apply filters if provided
    if (fromDate != null) {
      allWorksList = allWorksList.where((work) => work.date != null && DateTime.parse(work.date!).isAfter(fromDate)).toList();
    }
    if (toDate != null) {
      allWorksList = allWorksList.where((work) => work.date != null && DateTime.parse(work.date!).isBefore(toDate)).toList();
    }
    if (block != null && block.isNotEmpty) {
      allWorksList = allWorksList.where((work) => work.blockNo != null && work.blockNo!.contains(block)).toList();
    }

    // Update the observable list
    allWorks.value = allWorksList;
  }

  Future<void> addWorks(IronWorksModel ironWorksModel) async {
    await ironWorksRepository.add(ironWorksModel);
    fetchAllWorks(); // Optionally refresh after adding
  }

  void updateWorks(IronWorksModel ironWorksModel) {
    ironWorksRepository.update(ironWorksModel);
    fetchAllWorks(); // Refresh after updating
  }

  void deleteWorks(int id) {
    ironWorksRepository.delete(id);
    fetchAllWorks(); // Refresh after deleting
  }
}
