class MainGateFoundationWorkModel{
  int? id;
  dynamic blockNo;
  dynamic workStatus;
  dynamic date;
  dynamic time;

  MainGateFoundationWorkModel ({
    this.id,
    this.blockNo,
    this.workStatus,
    this.date,
    this.time

  });

  factory MainGateFoundationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainGateFoundationWorkModel(
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
