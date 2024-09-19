class GrassWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? grassWorkCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  GrassWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.grassWorkCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory GrassWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return GrassWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        grassWorkCompStatus:json['grassWorkCompStatus'],
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
      'grassWorkCompStatus':grassWorkCompStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
