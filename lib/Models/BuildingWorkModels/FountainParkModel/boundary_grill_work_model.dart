class BoundaryGrillWorkModel{
  int? id;
  dynamic startDate;
 dynamic expectedCompDate;
  String?  boundaryWorkCompStatus;
  dynamic date;
  dynamic time;

  BoundaryGrillWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.boundaryWorkCompStatus,
    this.date,
    this.time,
  });

  factory BoundaryGrillWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return BoundaryGrillWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate']!= null ? DateTime.parse(json['expectedCompDate']) : null,
        boundaryWorkCompStatus:json['boundaryWorkCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate?.toString(),
      'expectedCompDate':expectedCompDate?.toString(),
      'boundaryWorkCompStatus':boundaryWorkCompStatus,
      'date':date,
      'time':time,


    };
  }
}
