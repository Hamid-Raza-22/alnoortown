class BackFillingWsModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic roadSide;
  dynamic totalLength;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic waterSupplyBackFillingCompStatus;

  BackFillingWsModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.roadSide,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.waterSupplyBackFillingCompStatus,

  });

  factory BackFillingWsModel.fromMap(Map<dynamic,dynamic>json)
  {
    return BackFillingWsModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        roadSide: json['roadSide'],
        totalLength: json['totalLength'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        waterSupplyBackFillingCompStatus:json['waterSupplyBackFillingCompStatus']
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
      'waterSupplyBackFillingCompStatus':waterSupplyBackFillingCompStatus,

    };
  }
}
