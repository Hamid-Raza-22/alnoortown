class MainEntranceTilesWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String?  mainEntranceTilesWorkCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MainEntranceTilesWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mainEntranceTilesWorkCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MainEntranceTilesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainEntranceTilesWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        mainEntranceTilesWorkCompStatus:json['mainEntranceTilesWorkCompStatus'],
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
      'mainEntranceTilesWorkCompStatus':mainEntranceTilesWorkCompStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
