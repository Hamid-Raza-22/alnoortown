class PaintWorkModel{
  int? id;
  dynamic blockNo;
  dynamic paintWorkStatus;
  dynamic date;
  dynamic time;

  PaintWorkModel({
    this.id,
    this.blockNo,
    this.paintWorkStatus,
    this.date,
    this.time
  });

  factory PaintWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PaintWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        paintWorkStatus: json['paintWorkStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'paintWorkStatus':paintWorkStatus,
      'date':date,
      'time':time,

    };
  }
}
