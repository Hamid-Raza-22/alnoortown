class BaseSubBaseCompactionModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic totalLength;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic baseSubBaseCompStatus;

  BaseSubBaseCompactionModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.baseSubBaseCompStatus,
  });

  factory BaseSubBaseCompactionModel.fromMap(Map<dynamic,dynamic>json)
  {
    return BaseSubBaseCompactionModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        totalLength: json['totalLength'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        baseSubBaseCompStatus:json['baseSubBaseCompStatus']
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
      'baseSubBaseCompStatus':baseSubBaseCompStatus,


    };
  }
}
