

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_exavation_model.dart';



class PolesExavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PolesExavationModel>> getPolesExavation() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameLight,columns:['id','blockNo','streetNo','lengthTotal']);
    List<PolesExavationModel> polesExavation = [];
    for(int i = 0; i<maps.length; i++)
    {
      polesExavation.add(PolesExavationModel.fromMap(maps[i]));
    }
    return polesExavation;
  }



  Future<int>add(PolesExavationModel polesExavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePolesExavation,polesExavationModel.toMap());
  }

  Future<int>update(PolesExavationModel polesExavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePolesExavation,polesExavationModel.toMap(),
        where: 'id = ?', whereArgs: [polesExavationModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePolesExavation,
        where: 'id = ?', whereArgs: [id]);
  }
}