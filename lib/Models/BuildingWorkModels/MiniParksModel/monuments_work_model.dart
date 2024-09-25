class MonumentsWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String?  monumentsWorkCompStatus;
  dynamic date;
  dynamic time;
  int posted;
  MonumentsWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.monumentsWorkCompStatus,
    this.date,
    this.time,
    this.posted = 0,
  });

  factory MonumentsWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MonumentsWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        monumentsWorkCompStatus:json['monumentsWorkCompStatus'],
        date:  json['monuments_date'],
        time:  json['time'],
      posted: json['posted']??0 // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'monumentsWorkCompStatus':monumentsWorkCompStatus,
      'monuments_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
