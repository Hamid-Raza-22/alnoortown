class MpPlantationWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? mpPCompStatus;
  dynamic date;
  dynamic time;

  MpPlantationWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mpPCompStatus,
    this.date,
    this.time
  });

  factory MpPlantationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MpPlantationWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        mpPCompStatus:json['mpPCompStatus'],
        date:  json['date'],
        time:  json['time']
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

    };
  }
}
