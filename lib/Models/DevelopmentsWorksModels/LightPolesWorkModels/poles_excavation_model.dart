class PolesExcavationModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic noOfExcavation;
  dynamic date;
  dynamic time;
  PolesExcavationModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.noOfExcavation,
    this.date,
    this.time
  });

  factory PolesExcavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PolesExcavationModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
        noOfExcavation: json['noOfExcavation'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'noOfExcavation':noOfExcavation,
      'date':date,
      'time':time,
    };
  }
}
