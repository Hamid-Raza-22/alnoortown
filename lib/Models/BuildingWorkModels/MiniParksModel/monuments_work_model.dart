class MonumentsWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String?  monumentsWorkCompStatus;
  dynamic date;
  dynamic time;

  MonumentsWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.monumentsWorkCompStatus,
    this.date,
    this.time
  });

  factory MonumentsWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MonumentsWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        monumentsWorkCompStatus:json['monumentsWorkCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'monumentsWorkCompStatus':monumentsWorkCompStatus,
      'date':date,
      'time':time,

    };
  }
}
