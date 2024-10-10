import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/AttendenceModels/attendance_in_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class AttendanceInRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<AttendanceInModel>> getAttendanceIn() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameAttendanceIn,
        columns: ['id', 'time_in', 'latitude', 'longitude','live_address','attendance_in_date','user_id','posted']
    );

    // Print the raw data retrieved from the database
    if (kDebugMode) {
      print('Raw data from database:');
    }
    for (var map in maps) {
      if (kDebugMode) {
        print(map);
      }
    }

    // Convert the raw data into a list
    List<AttendanceInModel> attendanceIn = [];
    for (int i = 0; i < maps.length; i++) {
      attendanceIn.add(AttendanceInModel.fromMap(maps[i]));
    }

    if (kDebugMode) {
      print('Parsed AttendanceInModel objects:');
    }

    return attendanceIn;
  }
  Future<void> fetchAndSaveAttendanceData() async {
    print('${Config.getApiUrlAttendanceIn}$userId');
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlAttendanceIn}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      AttendanceInModel model = AttendanceInModel.fromMap(item);
      await dbClient.insert(tableNameAttendanceIn, model.toMap());
    }
  }

  Future<List<AttendanceInModel>> getUnPostedAttendanceIn() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameAttendanceIn,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<AttendanceInModel> attendanceIn = maps.map((map) => AttendanceInModel.fromMap(map)).toList();
    return attendanceIn;
  }
  Future<int>add(AttendanceInModel attendanceInModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameAttendanceIn,attendanceInModel.toMap());
  }

  Future<int>update(AttendanceInModel attendanceInModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameAttendanceIn,attendanceInModel.toMap(),
        where: 'id = ?', whereArgs: [attendanceInModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameAttendanceIn,
        where: 'id = ?', whereArgs: [id]);
  }
}