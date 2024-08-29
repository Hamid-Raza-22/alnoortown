class RoadsEdgingWorkModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic roadSide;
  dynamic totalLength;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic roadsEdgingCompStatus;

  RoadsEdgingWorkModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.roadSide,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.roadsEdgingCompStatus,

  });

  factory RoadsEdgingWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return RoadsEdgingWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        roadSide: json['roadSide'],
        totalLength: json['totalLength'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        roadsEdgingCompStatus:json['roadsEdgingCompStatus']
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
      'roadsEdgingCompStatus':roadsEdgingCompStatus,

    };
  }
}
