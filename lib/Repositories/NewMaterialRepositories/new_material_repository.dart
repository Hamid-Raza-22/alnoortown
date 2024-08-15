

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/NewMaterialModels/new_material_model.dart';



class NewMaterialRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<NewMaterialModel>> getNewMaterial() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameNewMaterials,columns:['id','sand','base','subBase','waterBound','otherMaterial']);
    List<NewMaterialModel> newMaterial = [];
    for(int i = 0; i<maps.length; i++)
    {
      newMaterial.add(NewMaterialModel.fromMap(maps[i]));
    }
    return newMaterial;
  }



  Future<int>add(NewMaterialModel newMaterialModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameNewMaterials,newMaterialModel.toMap());
  }

  Future<int>update(NewMaterialModel newMaterialModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameNewMaterials,newMaterialModel.toMap(),
        where: 'id = ?', whereArgs: [newMaterialModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameNewMaterials,
        where: 'id = ?', whereArgs: [id]);
  }
}