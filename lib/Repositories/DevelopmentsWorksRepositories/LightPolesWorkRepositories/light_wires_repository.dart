

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/light_wires_model.dart';



class LightWiresRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<LightWiresModel>> getLightWires() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameLight,columns:['id','blockNo','streetNo','machine','timeIn','timeOut']);
    List<LightWiresModel> lightWires = [];
    for(int i = 0; i<maps.length; i++)
    {
      lightWires.add(LightWiresModel.fromMap(maps[i]));
    }
    return lightWires;
  }



  Future<int>add(LightWiresModel lightWiresModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameLight,lightWiresModel.toMap());
  }

  Future<int>update(LightWiresModel lightWiresModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameLight,lightWiresModel.toMap(),
        where: 'id = ?', whereArgs: [lightWiresModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameLight,
        where: 'id = ?', whereArgs: [id]);
  }
}