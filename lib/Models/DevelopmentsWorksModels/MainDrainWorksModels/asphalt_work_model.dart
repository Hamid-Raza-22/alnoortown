class AsphaltWorkModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? numOfTons;
  String? backFillingStatus;



  AsphaltWorkModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.numOfTons,
    this.backFillingStatus,


  });

  factory AsphaltWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return AsphaltWorkModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      numOfTons: json['numOfTons'],
      backFillingStatus: json['backFillingStatus'],

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'backFillingStatus':backFillingStatus,

    };
  }
}
