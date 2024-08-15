

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/shuttering_work_model.dart';



class ShutteringWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ShutteringWorkModel>> getShutteringWork() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameShuttering,columns:['id','blockNo','streetNo','completedLength']);
    List<ShutteringWorkModel> shutteringWorkModel = [];
    for(int i = 0; i<maps.length; i++)
    {
      shutteringWorkModel.add(ShutteringWorkModel.fromMap(maps[i]));
    }
    return shutteringWorkModel;
  }



  Future<int>add(ShutteringWorkModel shutteringWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameDrain,shutteringWorkModel.toMap());
  }

  Future<int>update(ShutteringWorkModel shutteringWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameDrain,shutteringWorkModel.toMap(),
        where: 'id = ?', whereArgs: [shutteringWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameShuttering,
        where: 'id = ?', whereArgs: [id]);
  }
}