class AsphaltWorkModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic numOfTons;
  dynamic backFillingStatus;
  dynamic date;
  dynamic time;

  AsphaltWorkModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.numOfTons,
    this.backFillingStatus,
    this.date,
    this.time

  });

  factory AsphaltWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return AsphaltWorkModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      numOfTons: json['numOfTons'],
      backFillingStatus: json['backFillingStatus'],
        date:  json['date'],
        time:  json['time']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'numOfTons':numOfTons,
      'streetNo':streetNo,
      'backFillingStatus':backFillingStatus,
      'date':date,
      'time':time,
    };
  }
}
