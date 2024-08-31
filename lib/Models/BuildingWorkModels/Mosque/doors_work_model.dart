class DoorsWorkModel{
  int? id;
  dynamic blockNo;
  dynamic doorsWorkStatus;
  dynamic date;
  dynamic time;
  DoorsWorkModel({
    this.id,
    this.blockNo,
    this.doorsWorkStatus,
    this.date,
    this.time
  });

  factory DoorsWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return DoorsWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        doorsWorkStatus: json['doorsWorkStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'doorsWorkStatus':doorsWorkStatus,
      'date':date,
      'time':time,

    };
  }
}
