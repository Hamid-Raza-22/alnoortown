class GazeboWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String?  gazeboWorkCompStatus;
  dynamic date;
  dynamic time;

  GazeboWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.gazeboWorkCompStatus,
    this.date,
    this.time

  });

  factory GazeboWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return GazeboWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        gazeboWorkCompStatus:json['gazeboWorkCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'gazeboWorkCompStatus':gazeboWorkCompStatus,
      'date':date,
      'time':time,

    };
  }
}
