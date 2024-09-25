class NewMaterialModel{
  int? id;
  dynamic sand;
  dynamic soil;
  dynamic base;
  dynamic subBase;
  dynamic waterBound;
  dynamic otherMaterial;
  dynamic otherMaterialValue;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  NewMaterialModel({
    this.id,
    this.sand,
    this.soil,
    this.base,
    this.subBase,
    this.waterBound,
    this.otherMaterial,
    this.otherMaterialValue,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory NewMaterialModel.fromMap(Map<dynamic,dynamic>json)
  {
    return NewMaterialModel(
      id: json['id'],
      sand: json['sand'],
      soil: json['soil'],
      base: json['base'],
      subBase: json['subBase'],
      waterBound: json['waterBound'],
      otherMaterial: json['otherMaterial'],
        otherMaterialValue: json['otherMaterialValue'],
        date:  json['new_material_date'],
        time:  json['time'],
      posted: json['posted']??0 // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'sand':sand,
      'soil':soil,
      'base':base,
      'subBase':subBase,
      'waterBound':waterBound,
      'otherMaterial':otherMaterial,
      'otherMaterialValue':otherMaterialValue,
      'new_material_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
