class SoilCompactionModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic totalLength;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic soilCompStatus;

  SoilCompactionModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.soilCompStatus,

  });

  factory SoilCompactionModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SoilCompactionModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        totalLength: json['totalLength'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        soilCompStatus:json['soilCompStatus']
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
      'soilCompStatus':soilCompStatus,

    };
  }
}
