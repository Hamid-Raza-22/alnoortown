

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/tanker_model.dart';



class TankerRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<TankerModel>> getTanker() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameTanker,columns:['id','blockNo','streetNo','tankerNo']);
    List<TankerModel> tanker = [];
    for(int i = 0; i<maps.length; i++)
    {
      tanker.add(TankerModel.fromMap(maps[i]));
    }
    return tanker;
  }



  Future<int>add(TankerModel tankerModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameTanker,tankerModel.toMap());
  }

  Future<int>update(TankerModel tankerModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameTanker,tankerModel.toMap(),
        where: 'id = ?', whereArgs: [tankerModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameTanker,
        where: 'id = ?', whereArgs: [id]);
  }
}