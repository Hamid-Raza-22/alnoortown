class AsphaltWorkModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic numOfTons;
  dynamic backFillingStatus;
  dynamic date;


  AsphaltWorkModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.numOfTons,
    this.backFillingStatus,
    this.date

  });

  factory AsphaltWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return AsphaltWorkModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      numOfTons: json['numOfTons'],
      backFillingStatus: json['backFillingStatus'],
        date:  json['date']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'backFillingStatus':backFillingStatus,
      'date':date
    };
  }
}
