class WalkingTracksWorkModel{
  int? id;
  String? typeOfWork;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? walkingTracksCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  WalkingTracksWorkModel({
    this.id,
    this.typeOfWork,
    this.startDate,
    this.expectedCompDate,
    this.walkingTracksCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory WalkingTracksWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return WalkingTracksWorkModel(
        id: json['id'],
        typeOfWork: json['typeOfWork'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        walkingTracksCompStatus:json['walkingTracksCompStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'typeOfWork':typeOfWork,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'walkingTracksCompStatus':walkingTracksCompStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
