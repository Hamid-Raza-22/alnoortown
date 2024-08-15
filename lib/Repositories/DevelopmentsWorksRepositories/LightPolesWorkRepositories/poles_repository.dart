

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_model.dart';



class PolesRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PolesModel>> getPoles() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameLight,columns:['id','blockNo','streetNo','totalLength']);
    List<PolesModel> poles = [];
    for(int i = 0; i<maps.length; i++)
    {
      poles.add(PolesModel.fromMap(maps[i]));
    }
    return poles;
  }



  Future<int>add(PolesModel polesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePoles,polesModel.toMap());
  }

  Future<int>update(PolesModel polesModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePoles,polesModel.toMap(),
        where: 'id = ?', whereArgs: [polesModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePoles,
        where: 'id = ?', whereArgs: [id]);
  }
}