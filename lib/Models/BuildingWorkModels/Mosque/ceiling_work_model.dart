class CeilingWorkModel{
  int? id;
  dynamic blockNo;
  dynamic ceilingWorkStatus;
  dynamic date;

  CeilingWorkModel({
    this.id,
    this.blockNo,
    this.ceilingWorkStatus,
    this.date

  });

  factory CeilingWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return CeilingWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        ceilingWorkStatus: json['ceilingWorkStatus'],
        date:  json['date']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'ceilingWorkStatus':ceilingWorkStatus,
      'date':date

    };
  }
}
