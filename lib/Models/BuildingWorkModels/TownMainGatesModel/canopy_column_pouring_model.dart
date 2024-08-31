class CanopyColumnPouringModel{
  int? id;
  dynamic blockNo;
  dynamic workStatus;
  dynamic date;
  dynamic time;

  CanopyColumnPouringModel ({
    this.id,
    this.blockNo,
    this.workStatus,
    this.date,
    this.time

  });

  factory CanopyColumnPouringModel.fromMap(Map<dynamic,dynamic>json)
  {
    return CanopyColumnPouringModel(
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
