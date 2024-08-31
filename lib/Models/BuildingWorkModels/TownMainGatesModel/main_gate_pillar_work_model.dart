class MainGatePillarWorkModel{
  int? id;
  dynamic blockNo;
  dynamic workStatus;
  dynamic date;
  dynamic time;
  MainGatePillarWorkModel ({
    this.id,
    this.blockNo,
    this.workStatus,
    this.date,
    this.time
  });

  factory MainGatePillarWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainGatePillarWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        workStatus: json['workStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'workStatus':workStatus,
      'date':date,
      'time':time,
    };
  }
}
