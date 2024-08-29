class WaterFirstModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic roadSide;
  dynamic totalLength;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic waterSupplyCompStatus;

  WaterFirstModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.roadSide,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.waterSupplyCompStatus,

  });

  factory WaterFirstModel.fromMap(Map<dynamic,dynamic>json)
  {
    return WaterFirstModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        roadSide: json['roadSide'],
        totalLength: json['totalLength'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        waterSupplyCompStatus:json['waterSupplyCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'roadNo':roadNo,
      'roadSide':roadSide,
      'totalLength':totalLength,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'waterSupplyCompStatus':waterSupplyCompStatus,

    };
  }
}
