class PolesModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic noOfPoles;
  dynamic date;
  dynamic time;
  PolesModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.noOfPoles,
    this.date,
    this.time
  });

  factory PolesModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PolesModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
        noOfPoles: json['noOfPoles'],
        date:  json['date'],
        time:  json['time']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'noOfPoles':noOfPoles,
      'date':date,
      'time':time,
    };
  }
}
