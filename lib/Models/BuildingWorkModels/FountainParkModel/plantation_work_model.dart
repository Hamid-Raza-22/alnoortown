class PlantationWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? plantationCompStatus;
  dynamic date;
  dynamic time;

  PlantationWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.plantationCompStatus,
    this.date,
    this.time
  });

  factory PlantationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PlantationWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        plantationCompStatus:json['plantationCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'plantationCompStatus':plantationCompStatus,
      'date':date,
      'time':time,

    };
  }
}
