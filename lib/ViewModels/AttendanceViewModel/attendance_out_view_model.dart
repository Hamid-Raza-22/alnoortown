
import 'package:al_noor_town/Models/AttendenceModels/attendance_out_model.dart';
import 'package:al_noor_town/Repositories/AttendanceRepositories/attendance_out_repository.dart';
import 'package:get/get.dart';

class AttendanceOutViewModel extends GetxController {

  var allAttendOut = <AttendanceOutModel>[].obs;
  AttendanceOutRepository attendanceOutRepository = AttendanceOutRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllBrick();
  }

  fetchAllAttendOut() async{
    var attendanceOut = await attendanceOutRepository.getAttendanceOut();
    allAttendOut .value = attendanceOut;

  }

  addAttendOut(AttendanceOutModel attendanceOutModel){
    attendanceOutRepository.add(attendanceOutModel);
    //fetchAllBrick();
  }

  updateAttendOut(AttendanceOutModel attendanceOutModel){
    attendanceOutRepository.update(attendanceOutModel);
    fetchAllAttendOut();
  }

  deleteAttendOut(int id){
    attendanceOutRepository.delete(id);
    fetchAllAttendOut();
  }

}

