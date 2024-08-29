class CanopyColumnPouringModel{
  int? id;
  dynamic blockNo;
  dynamic workStatus;
  dynamic date;

  CanopyColumnPouringModel ({
    this.id,
    this.blockNo,
    this.workStatus,
    this.date

  });

  factory CanopyColumnPouringModel.fromMap(Map<dynamic,dynamic>json)
  {
    return CanopyColumnPouringModel(
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
