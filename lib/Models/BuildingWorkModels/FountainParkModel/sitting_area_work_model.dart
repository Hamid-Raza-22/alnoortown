class SittingAreaWorkModel{
  int? id;
  String?  typeOfWork;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? sittingAreaCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  SittingAreaWorkModel({
    this.id,
    this.typeOfWork,
    this.startDate,
    this.expectedCompDate,
    this.sittingAreaCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory SittingAreaWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SittingAreaWorkModel(
        id: json['id'],
        typeOfWork: json['typeOfWork'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        sittingAreaCompStatus:json['sittingAreaCompStatus'],
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
      'sittingAreaCompStatus':sittingAreaCompStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
