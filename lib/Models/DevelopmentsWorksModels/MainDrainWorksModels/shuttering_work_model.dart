class ShutteringWorkModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic completedLength;
  dynamic date;
  dynamic time;

  ShutteringWorkModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.completedLength,
    this.date,
    this.time
  });

  factory ShutteringWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ShutteringWorkModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      completedLength: json['completedLength'],
        date:  json['date'],
        time:  json['time']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'completedLength':completedLength,
      'date':date,
      'time':time,
    };
  }
}
