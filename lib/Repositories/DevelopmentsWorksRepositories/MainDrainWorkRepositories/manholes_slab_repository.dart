

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/manholes_slab_model.dart';



class ManholesSlabRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ManholesSlabModel>> getManHolesSlab() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameSlab,columns:['id','blockNo','streetNo','numOfCompSlab' ]);
    List<ManholesSlabModel> manHolesSlab = [];
    for(int i = 0; i<maps.length; i++)
    {
      manHolesSlab.add(ManholesSlabModel.fromMap(maps[i]));
    }
    return manHolesSlab;
  }



  Future<int>add(ManholesSlabModel manHolesSlabModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameSlab,manHolesSlabModel.toMap());
  }

  Future<int>update(ManholesSlabModel manHolesSlabModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameSlab,manHolesSlabModel.toMap(),
        where: 'id = ?', whereArgs: [manHolesSlabModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameSlab,
        where: 'id = ?', whereArgs: [id]);
  }
}