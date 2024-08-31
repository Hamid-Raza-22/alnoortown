class GrassWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? grassWorkCompStatus;
  dynamic date;
  dynamic time;
  GrassWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.grassWorkCompStatus,
    this.date,
    this.time
  });

  factory GrassWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return GrassWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        grassWorkCompStatus:json['grassWorkCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'grassWorkCompStatus':grassWorkCompStatus,
      'date':date,
      'time':time,

    };
  }
}
