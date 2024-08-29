class RoadsShoulderWorkModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic roadSide;
  dynamic totalLength;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic roadsShoulderCompStatus;

  RoadsShoulderWorkModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.roadSide,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.roadsShoulderCompStatus,

  });

  factory RoadsShoulderWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return RoadsShoulderWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        roadSide: json['roadSide'],
        totalLength: json['totalLength'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        roadsShoulderCompStatus:json['roadsShoulderCompStatus']
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
      'roadsShoulderCompStatus':roadsShoulderCompStatus,

    };
  }
}
