class BoundaryGrillWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String?  boundaryWorkCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  BoundaryGrillWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.boundaryWorkCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory BoundaryGrillWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return BoundaryGrillWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate']!= null ? DateTime.parse(json['expectedCompDate']) : null,
        boundaryWorkCompStatus:json['boundaryWorkCompStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'] // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate?.toString(),
      'expectedCompDate':expectedCompDate?.toString(),
      'boundaryWorkCompStatus':boundaryWorkCompStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
