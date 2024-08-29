
import 'package:al_noor_town/Models/AttendenceModels/attendance_in_model.dart';
import 'package:al_noor_town/Repositories/AttendanceRepositories/attendance_in_repository.dart';
import 'package:get/get.dart';

class AttendanceInViewModel extends GetxController {

  var allAttend = <AttendanceInModel>[].obs;
  AttendanceInRepository attendanceInRepository = AttendanceInRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllBrick();
  }

  fetchAllAttend() async{
    var attendance = await attendanceInRepository.getAttendanceIn();
    allAttend .value = attendance;

  }

  addAttend(AttendanceInModel attendanceInModel){
    attendanceInRepository.add(attendanceInModel);
    //fetchAllBrick();
  }

  updateAttend(AttendanceInModel attendanceInModel){
    attendanceInRepository.update(attendanceInModel);
    fetchAllAttend();
  }

  deleteAttend(int id){
    attendanceInRepository.delete(id);
    fetchAllAttend();
  }

}

