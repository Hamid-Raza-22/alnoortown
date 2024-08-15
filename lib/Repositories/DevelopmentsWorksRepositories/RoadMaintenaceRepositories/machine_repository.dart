

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/machine_model.dart';


class MachineRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MachineModel>> getMachine() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameMachine,columns:['id','blockNo','streetNo','machine','timeIn','timeOut']);
    List<MachineModel> machine = [];
    for(int i = 0; i<maps.length; i++)
    {
      machine.add(MachineModel.fromMap(maps[i]));
    }
    return machine;
  }



  Future<int>add(MachineModel machineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMachine,machineModel.toMap());
  }

  Future<int>update(MachineModel machineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMachine,machineModel.toMap(),
        where: 'id = ?', whereArgs: [machineModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMachine,
        where: 'id = ?', whereArgs: [id]);
  }
}