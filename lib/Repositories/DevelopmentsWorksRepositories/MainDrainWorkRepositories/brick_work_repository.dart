

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/asphalt_work_model.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/brick_work_model.dart';



class BrickWorkRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<BrickWorkModel>> getAsphaltWork() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameAsphalt,columns:['id','blockNo','streetNo','completedLength']);
    List<BrickWorkModel> brickWork = [];
    for(int i = 0; i<maps.length; i++)
    {
      brickWork.add(BrickWorkModel.fromMap(maps[i]));
    }
    return brickWork;
  }



  Future<int>add(BrickWorkModel brickWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameBrick,brickWorkModel.toMap());
  }

  Future<int>update(BrickWorkModel brickWorkModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameBrick,brickWorkModel.toMap(),
        where: 'id = ?', whereArgs: [brickWorkModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameBrick,
        where: 'id = ?', whereArgs: [id]);
  }
}