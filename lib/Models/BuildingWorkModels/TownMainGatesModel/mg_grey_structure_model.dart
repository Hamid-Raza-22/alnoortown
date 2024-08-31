class MgGreyStructureModel{
  int? id;
  dynamic blockNo;
  dynamic workStatus;
  dynamic date;
  dynamic time;
  MgGreyStructureModel ({
    this.id,
    this.blockNo,
    this.workStatus,
    this.date,
    this.time
  });

  factory MgGreyStructureModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MgGreyStructureModel(
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
