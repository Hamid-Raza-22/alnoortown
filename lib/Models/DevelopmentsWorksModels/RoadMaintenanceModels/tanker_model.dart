class TankerModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic tankerNo;
  dynamic date;
  dynamic time;
  TankerModel ({
    this.id,
    this.blockNo,
    this.streetNo,
    this.tankerNo,
    this.date,
    this.time

  });

  factory TankerModel.fromMap(Map<dynamic,dynamic>json)
  {
    return TankerModel(
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
