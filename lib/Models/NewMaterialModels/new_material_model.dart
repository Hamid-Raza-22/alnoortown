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
    this.time
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
        date:  json['date'],
        time:  json['time']

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
      'date':date,
      'time':time,

    };
  }
}
