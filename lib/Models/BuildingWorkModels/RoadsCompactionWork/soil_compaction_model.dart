class SoilCompactionModel{
  int? id;
  String? block_no;
  String? roadNo;
  String?  totalLength;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String?  soilCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  SoilCompactionModel({
    this.id,
    this.block_no,
    this.roadNo,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.soilCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory SoilCompactionModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SoilCompactionModel(
        id: json['id'],
        block_no: json['block_no'],
        roadNo: json['roadNo'],
        totalLength: json['totalLength'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        soilCompStatus:json['soilCompStatus'],
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
      'totalLength':totalLength,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'soilCompStatus':soilCompStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
