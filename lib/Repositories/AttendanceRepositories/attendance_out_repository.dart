

import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/AttendenceModels/attendance_out_model.dart';
import 'package:al_noor_town/Services/ApiServices/api_service.dart';
import 'package:al_noor_town/Services/FirebaseServices/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class AttendanceOutRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<AttendanceOutModel>> getAttendanceOut() async {
    // Get the database client
    var dbClient = await dbHelper.db;

    // Query the database
    List<Map> maps = await dbClient.query(
        tableNameAttendanceOut,
        columns: ['id', 'time_out', 'latitude', 'longitude','address_out','attendance_out_date','user_id','posted']
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
    List<AttendanceOutModel> attendanceOut = [];
    for (int i = 0; i < maps.length; i++) {
      attendanceOut.add(AttendanceOutModel.fromMap(maps[i]));
    }


    if (kDebugMode) {
      print('Parsed AttendanceOutModel objects:');
    }


    return attendanceOut;
  }
  Future<void> fetchAndSaveAttendanceOutData() async {
    print('${Config.getApiUrlAttendanceOut}$userId');
    List<dynamic> data = await ApiService.getData('${Config.getApiUrlAttendanceOut}$userId');
    var dbClient = await dbHelper.db;

    // Save data to database
    for (var item in data) {
      item['posted'] = 1; // Set posted to 1
      AttendanceOutModel model = AttendanceOutModel.fromMap(item);
      await dbClient.insert(tableNameAttendanceOut, model.toMap());
    }
  }

  Future<List<AttendanceOutModel>> getUnPostedAttendanceOut() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(
      tableNameAttendanceOut,
      where: 'posted = ?',
      whereArgs: [0],  // Fetch machines that have not been posted
    );

    List<AttendanceOutModel> attendanceOutModel = maps.map((map) => AttendanceOutModel.fromMap(map)).toList();
    return attendanceOutModel;
  }


  Future<int>add(AttendanceOutModel attendanceOutModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameAttendanceOut,attendanceOutModel.toMap());
  }

  Future<int>update(AttendanceOutModel attendanceOutModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameAttendanceOut,attendanceOutModel.toMap(),
        where: 'id = ?', whereArgs: [attendanceOutModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameAttendanceOut,
        where: 'id = ?', whereArgs: [id]);
  }
}