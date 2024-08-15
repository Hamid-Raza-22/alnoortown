

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/manholes_model.dart';





class ManholesRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ManholesModel>> getManholes() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameManholes,columns:['id','blockNo','streetNo','length']);
    List<ManholesModel> filing = [];
    for(int i = 0; i<maps.length; i++)
    {
      filing.add(ManholesModel.fromMap(maps[i]));
    }
    return filing;
  }



  Future<int>add(ManholesModel manholesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameManholes,manholesModel.toMap());
  }

  Future<int>update(ManholesModel manholesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameManholes,manholesModel.toMap(),
        where: 'id = ?', whereArgs: [manholesModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameManholes,
        where: 'id = ?', whereArgs: [id]);
  }
}