class GazeboWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String?  gazeboWorkCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  GazeboWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.gazeboWorkCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)


  });

  factory GazeboWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return GazeboWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        gazeboWorkCompStatus:json['gazeboWorkCompStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'gazeboWorkCompStatus':gazeboWorkCompStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
