

import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Globals/Globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/filing_model.dart';




class FillingRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<FilingModel>> getFiling() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableNameExavation,columns:['id','blockNo','streetNo','status']);
    List<FilingModel> filing = [];
    for(int i = 0; i<maps.length; i++)
    {
      filing.add(FilingModel.fromMap(maps[i]));
    }
    return filing;
  }



  Future<int>add(FilingModel filingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableNameMachine,filingModel.toMap());
  }

  Future<int>update(FilingModel filingModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableNameFiling,filingModel.toMap(),
        where: 'id = ?', whereArgs: [filingModel.id]);

  }

  Future<int>delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableNameFiling,
        where: 'id = ?', whereArgs: [id]);
  }
}