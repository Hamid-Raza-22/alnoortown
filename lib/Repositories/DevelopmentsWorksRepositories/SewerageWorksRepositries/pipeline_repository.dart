

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/pipeline_model.dart';



class PipelineRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<PipelineModel>> getPipeline() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameManholes,columns:['id','blockNo','streetNo','length']);
    List<PipelineModel> filing = [];
    for(int i = 0; i<maps.length; i++)
    {
      filing.add(PipelineModel.fromMap(maps[i]));
    }
    return filing;
  }



  Future<int>add(PipelineModel pipelineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNamePipeline,pipelineModel.toMap());
  }

  Future<int>update(PipelineModel pipelineModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNamePipeline,pipelineModel.toMap(),
        where: 'id = ?', whereArgs: [pipelineModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNamePipeline,
        where: 'id = ?', whereArgs: [id]);
  }
}