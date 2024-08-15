

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/plaster_work_model.dart';



class PlasterWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PlasterWorkModel>> getPlasterWork() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNamePlaster,columns:['id','blockNo','streetNo','completedLength']);
    List<PlasterWorkModel> plasterWork = [];
    for(int i = 0; i<maps.length; i++)
    {
      plasterWork.add(PlasterWorkModel.fromMap(maps[i]));
    }
    return plasterWork;
  }



  Future<int>add(PlasterWorkModel plasterWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePlaster,plasterWorkModel.toMap());
  }

  Future<int>update(PlasterWorkModel plasterWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePlaster,plasterWorkModel.toMap(),
        where: 'id = ?', whereArgs: [plasterWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePlaster,
        where: 'id = ?', whereArgs: [id]);
  }
}