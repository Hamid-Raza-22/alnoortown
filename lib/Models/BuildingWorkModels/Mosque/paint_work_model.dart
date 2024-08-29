class PaintWorkModel{
  int? id;
  dynamic blockNo;
  dynamic paintWorkStatus;
  dynamic date;

  PaintWorkModel({
    this.id,
    this.blockNo,
    this.paintWorkStatus,
    this.date
  });

  factory PaintWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PaintWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        paintWorkStatus: json['paintWorkStatus'],
        date:  json['date']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'paintWorkStatus':paintWorkStatus,
      'date':date

    };
  }
}
