class PlantationWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? plantationCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  PlantationWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.plantationCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory PlantationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PlantationWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        plantationCompStatus:json['plantationCompStatus'],
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
      'plantationCompStatus':plantationCompStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
