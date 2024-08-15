

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/exavation_model.dart';
import 'package:al_noor_town/Screens/Development%20Work/Sewerage%20Work/exavation.dart';



class ExavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ExavationModel>> getExavation() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameExavation,columns:['id','blockNo','streetNo','length']);
    List<ExavationModel> exavation = [];
    for(int i = 0; i<maps.length; i++)
    {
      exavation.add(ExavationModel.fromMap(maps[i]));
    }
    return exavation;
  }



  Future<int>add(ExavationModel exavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMachine,exavationModel.toMap());
  }

  Future<int>update(ExavationModel exavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameExavation,exavationModel.toMap(),
        where: 'id = ?', whereArgs: [exavationModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameExavation,
        where: 'id = ?', whereArgs: [id]);
  }
}