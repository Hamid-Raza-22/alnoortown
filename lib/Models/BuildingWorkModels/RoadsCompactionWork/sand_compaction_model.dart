class SandCompactionModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic totalLength;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic sandCompStatus;


  SandCompactionModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.sandCompStatus,


  });

  factory SandCompactionModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SandCompactionModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        totalLength: json['totalLength'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        sandCompStatus:json['sandCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'roadNo':roadNo,
      'totalLength':totalLength,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'sandCompStatus':sandCompStatus,


    };
  }
}
