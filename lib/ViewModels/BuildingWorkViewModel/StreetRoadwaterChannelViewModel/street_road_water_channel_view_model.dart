
import 'package:al_noor_town/Models/BuildingWorkModels/StreetRoadsWaterChannelsModel/street_road_water_channel_model.dart';
import 'package:al_noor_town/Repositories/BuildingWorkRepositories/StreetRoadsWaterChannelsRepository/street_road_water_channel_repository.dart';
import 'package:get/get.dart';

class StreetRoadWaterChannelViewModel extends GetxController {

  var allStreetRoad = <StreetRoadWaterChannelModel>[].obs;
  StreetRoadWaterChannelRepository streetRoadWaterChannelRepository = StreetRoadWaterChannelRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();

  }

  fetchAllStreetRoad() async{
    var streetRoad = await streetRoadWaterChannelRepository.getStreetRoadWaterChannel();
    allStreetRoad.value = streetRoad;

  }

  addStreetRoad(StreetRoadWaterChannelModel streetRoadWaterChannelModel){
    streetRoadWaterChannelRepository.add(streetRoadWaterChannelModel);

  }

  updateStreetRoad(StreetRoadWaterChannelModel streetRoadWaterChannelModel){
    streetRoadWaterChannelRepository.update(streetRoadWaterChannelModel);
    fetchAllStreetRoad();
  }

  deleteStreetRoad(int id){
    streetRoadWaterChannelRepository.delete(id);
    fetchAllStreetRoad();
  }

}

