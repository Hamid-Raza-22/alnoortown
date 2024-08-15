class IronWorksModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? numOfTons;
  String? backFillingStatus;



  IronWorksModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.numOfTons,
    this.backFillingStatus,


  });

  factory IronWorksModel.fromMap(Map<dynamic,dynamic>json)
  {
    return IronWorksModel(
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
