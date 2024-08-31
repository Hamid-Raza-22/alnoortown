class CubStonesWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String?  cubStonesCompStatus;
  dynamic date;
  dynamic time;


  CubStonesWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.cubStonesCompStatus,
    this.date,
    this.time
  });

  factory CubStonesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return CubStonesWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        cubStonesCompStatus:json['cubStonesCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'cubStonesCompStatus':cubStonesCompStatus,
      'date':date,
      'time':time,


    };
  }
}
