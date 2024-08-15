

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/MaterialShiftingModels/shifting_work_model.dart';




class ShiftingWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ShiftingWorkModel>> getShiftingWork() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameShifting,columns:['id','fromBlock','toBlock','numOfShift']);
    List<ShiftingWorkModel> shiftingWork = [];
    for(int i = 0; i<maps.length; i++)
    {
      shiftingWork.add(ShiftingWorkModel.fromMap(maps[i]));
    }
    return shiftingWork;
  }



  Future<int>add(ShiftingWorkModel shiftingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameShifting,shiftingWorkModel.toMap());
  }

  Future<int>update(ShiftingWorkModel shiftingWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameShifting,shiftingWorkModel.toMap(),
        where: 'id = ?', whereArgs: [shiftingWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameShifting,
        where: 'id = ?', whereArgs: [id]);
  }
}