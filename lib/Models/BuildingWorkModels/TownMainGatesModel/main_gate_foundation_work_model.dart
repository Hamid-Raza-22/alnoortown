class MainGateFoundationWorkModel{
  int? id;
  dynamic blockNo;
  dynamic workStatus;
  dynamic date;

  MainGateFoundationWorkModel ({
    this.id,
    this.blockNo,
    this.workStatus,
    this.date

  });

  factory MainGateFoundationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainGateFoundationWorkModel(
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
