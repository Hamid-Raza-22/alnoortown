

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/asphalt_work_model.dart';



class AsphaltWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<AsphaltWorkModel>> getAsphaltWork() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameAsphalt,columns:['id','blockNo','streetNo','numOfTons','backFillingStatus']);
    List<AsphaltWorkModel> asphaltWork = [];
    for(int i = 0; i<maps.length; i++)
    {
      asphaltWork.add(AsphaltWorkModel.fromMap(maps[i]));
    }
    return asphaltWork;
  }



  Future<int>add(AsphaltWorkModel asphaltWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameAsphalt,asphaltWorkModel.toMap());
  }

  Future<int>update(AsphaltWorkModel asphaltWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameAsphalt,asphaltWorkModel.toMap(),
        where: 'id = ?', whereArgs: [asphaltWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameAsphalt,
        where: 'id = ?', whereArgs: [id]);
  }
}