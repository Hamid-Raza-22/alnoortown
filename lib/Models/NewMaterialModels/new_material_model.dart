class NewMaterialModel{
  int? id;
  String? sand;
  String? soil;
  String? base;
  String? subBase;
  String? waterBound;
  String? otherMaterial;

  NewMaterialModel({
    this.id,
    this.sand,
    this.base,
    this.subBase,
    this.waterBound,
    this.otherMaterial,

  });

  factory NewMaterialModel.fromMap(Map<dynamic,dynamic>json)
  {
    return NewMaterialModel(
      id: json['id'],
      sand: json['sand'],
      base: json['base'],
      subBase: json['subBase'],
      waterBound: json['waterBound'],
      otherMaterial: json['otherMaterial'],


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'sand':sand,
      'base':base,
      'subBase':subBase,
      'waterBound':waterBound,
      'otherMaterial':otherMaterial,


    };
  }
}
