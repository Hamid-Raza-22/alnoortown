

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/main_drain_exavation_model.dart';



class MainDrainExavationRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<MainDrainExavationModel>> getMainDrainExavation() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameDrain,columns:['id','blockNo','streetNo','completedLength']);
    List<MainDrainExavationModel> mainDrainExavation = [];
    for(int i = 0; i<maps.length; i++)
    {
      mainDrainExavation.add(MainDrainExavationModel.fromMap(maps[i]));
    }
    return mainDrainExavation;
  }



  Future<int>add(MainDrainExavationModel mainDrainExavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameDrain,mainDrainExavationModel.toMap());
  }

  Future<int>update(MainDrainExavationModel mainDrainExavationModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameDrain,mainDrainExavationModel.toMap(),
        where: 'id = ?', whereArgs: [mainDrainExavationModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameDrain,
        where: 'id = ?', whereArgs: [id]);
  }
}