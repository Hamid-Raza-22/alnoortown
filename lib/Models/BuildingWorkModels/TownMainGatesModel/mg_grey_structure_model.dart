class MgGreyStructureModel{
  int? id;
  dynamic blockNo;
  dynamic workStatus;
  dynamic date;

  MgGreyStructureModel ({
    this.id,
    this.blockNo,
    this.workStatus,
    this.date

  });

  factory MgGreyStructureModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MgGreyStructureModel(
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
