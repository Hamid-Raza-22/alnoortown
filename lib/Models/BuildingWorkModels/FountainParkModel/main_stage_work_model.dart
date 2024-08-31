class MainStageWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? mainStageWorkCompStatus;
  dynamic date;
  dynamic time;

  MainStageWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mainStageWorkCompStatus,
    this.date,
    this.time

  });

  factory MainStageWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainStageWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        mainStageWorkCompStatus:json['mainStageWorkCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'mainStageWorkCompStatus':mainStageWorkCompStatus,
      'date':date,
      'time':time,

    };
  }
}
