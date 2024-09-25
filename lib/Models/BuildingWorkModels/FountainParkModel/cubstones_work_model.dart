class CubStonesWorkModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  String?  cubStonesCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted


  CubStonesWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.cubStonesCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)


  });

  factory CubStonesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return CubStonesWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        cubStonesCompStatus:json['cubStonesCompStatus'],
        date:  json['curbStone_Work_date'],
        time:  json['time'],
        posted: json['posted']?? 0
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'cubStonesCompStatus':cubStonesCompStatus,
      'curbStone_Work_date':date,
      'time':time,
      'posted': posted,  // Include the posted status
    };
  }
}
