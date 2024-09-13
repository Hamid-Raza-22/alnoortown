class WaterTankerModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic tankerNo;
  dynamic date;
  dynamic time;
  WaterTankerModel ({
    this.id,
    this.blockNo,
    this.streetNo,
    this.tankerNo,
    this.date,
    this.time

  });

  factory WaterTankerModel.fromMap(Map<dynamic,dynamic>json)
  {
    return WaterTankerModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      tankerNo: json['tankerNo'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'tankerNo':tankerNo,
      'date':date,
      'time':time,
    };
  }
}
