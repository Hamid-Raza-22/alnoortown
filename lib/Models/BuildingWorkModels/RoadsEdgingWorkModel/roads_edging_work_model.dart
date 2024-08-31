class RoadsEdgingWorkModel{
  int? id;
  String? blockNo;
  String?  roadNo;
  String?  roadSide;
  String?  totalLength;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String?  roadsEdgingCompStatus;
  dynamic date;
  dynamic time;
  RoadsEdgingWorkModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.roadSide,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.roadsEdgingCompStatus,
    this.date,
    this.time
  });

  factory RoadsEdgingWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return RoadsEdgingWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        roadSide: json['roadSide'],
        totalLength: json['totalLength'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        roadsEdgingCompStatus:json['roadsEdgingCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'roadNo':roadNo,
      'roadSide':roadSide,
      'totalLength':totalLength,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'roadsEdgingCompStatus':roadsEdgingCompStatus,
      'date':date,
      'time':time,
    };
  }
}
