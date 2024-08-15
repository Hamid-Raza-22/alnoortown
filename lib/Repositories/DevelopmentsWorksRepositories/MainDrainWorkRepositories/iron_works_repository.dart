

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/iron_works_model.dart';



class IronWorksRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<IronWorksModel>> getIronWorks() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameIron,columns:['id','blockNo','streetNo','numOfTons','backFillingStatus']);
    List<IronWorksModel> ironWorks = [];
    for(int i = 0; i<maps.length; i++)
    {
      ironWorks.add(IronWorksModel.fromMap(maps[i]));
    }
    return ironWorks;
  }



  Future<int>add(IronWorksModel ironWorksModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameIron,ironWorksModel.toMap());
  }

  Future<int>update(IronWorksModel ironWorksModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameIron,ironWorksModel.toMap(),
        where: 'id = ?', whereArgs: [ironWorksModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameIron,
        where: 'id = ?', whereArgs: [id]);
  }
}