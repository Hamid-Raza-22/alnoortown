class MpPlantationWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? mpPCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MpPlantationWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mpPCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MpPlantationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MpPlantationWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        mpPCompStatus:json['mpPCompStatus'],
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
      'mpPCompStatus':mpPCompStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
