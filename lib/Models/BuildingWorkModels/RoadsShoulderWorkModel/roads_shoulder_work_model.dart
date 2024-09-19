class RoadsShoulderWorkModel{
  int? id;
  String? blockNo;
  String? roadNo;
  String? roadSide;
  String? totalLength;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? roadsShoulderCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  RoadsShoulderWorkModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.roadSide,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.roadsShoulderCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory RoadsShoulderWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return RoadsShoulderWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        roadSide: json['roadSide'],
        totalLength: json['totalLength'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        roadsShoulderCompStatus:json['roadsShoulderCompStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

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
      'roadsShoulderCompStatus':roadsShoulderCompStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
