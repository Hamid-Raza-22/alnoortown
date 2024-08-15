

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/mosque_exavation_work.dart';





class MosqueExavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MosqueExavationWorkModel>> getMosqueExavation() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameMosque,columns:['id','blockNo','completionStatus']);
    List<MosqueExavationWorkModel> mosqueExavationWork = [];
    for(int i = 0; i<maps.length; i++)
    {
      mosqueExavationWork.add(MosqueExavationWorkModel.fromMap(maps[i]));
    }
    return mosqueExavationWork;
  }



  Future<int>add(MosqueExavationWorkModel mosqueExavationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMosque,mosqueExavationWorkModel.toMap());
  }

  Future<int>update(MosqueExavationWorkModel mosqueExavationWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameMosque,mosqueExavationWorkModel.toMap(),
        where: 'id = ?', whereArgs: [mosqueExavationWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameMosque,
        where: 'id = ?', whereArgs: [id]);
  }
}