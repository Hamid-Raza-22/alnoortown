class MgPlasterWorkModel{
  int? id;
  dynamic blockNo;
  dynamic workStatus;
  dynamic date;
  dynamic time;
  MgPlasterWorkModel ({
    this.id,
    this.blockNo,
    this.workStatus,
    this.date,
    this.time
  });

  factory MgPlasterWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MgPlasterWorkModel(
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
