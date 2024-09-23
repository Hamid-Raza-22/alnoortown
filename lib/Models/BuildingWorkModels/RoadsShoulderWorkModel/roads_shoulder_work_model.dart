class RoadsShoulderWorkModel{
  int? id;
  String? block_no;
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
    this.block_no,
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
        block_no: json['block_no'],
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
      'block_no':block_no,
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
