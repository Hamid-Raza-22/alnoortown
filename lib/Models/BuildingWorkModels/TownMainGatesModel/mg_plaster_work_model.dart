class MgPlasterWorkModel{
  int? id;
  dynamic blockNo;
  dynamic workStatus;
  dynamic date;

  MgPlasterWorkModel ({
    this.id,
    this.blockNo,
    this.workStatus,
    this.date

  });

  factory MgPlasterWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MgPlasterWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        workStatus: json['workStatus'],
        date:  json['date']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'workStatus':workStatus,
      'date':date

    };
  }
}
