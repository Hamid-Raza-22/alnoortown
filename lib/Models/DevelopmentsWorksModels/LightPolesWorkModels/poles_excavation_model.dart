class PolesExcavationModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic lengthTotal;
  dynamic date;
  dynamic time;
  PolesExcavationModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.lengthTotal,
    this.date,
    this.time
  });

  factory PolesExcavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PolesExcavationModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      lengthTotal: json['lengthTotal'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'lengthTotal':lengthTotal,
      'date':date,
      'time':time,
    };
  }
}
