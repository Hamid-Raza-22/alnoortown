class MainStageWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? mainStageWorkCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MainStageWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mainStageWorkCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MainStageWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainStageWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        mainStageWorkCompStatus:json['mainStageWorkCompStatus'],
        date:  json['main_stage_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'mainStageWorkCompStatus':mainStageWorkCompStatus,
      'main_stage_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
