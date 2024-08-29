class CompactionWaterBoundModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic totalLength;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic waterBoundCompStatus;


  CompactionWaterBoundModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.waterBoundCompStatus,


  });

  factory CompactionWaterBoundModel.fromMap(Map<dynamic,dynamic>json)
  {
    return CompactionWaterBoundModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        totalLength: json['totalLength'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        waterBoundCompStatus:json['waterBoundCompStatus']
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
      'waterBoundCompStatus':waterBoundCompStatus,

    };
  }
}
