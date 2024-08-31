class WalkingTracksWorkModel{
  int? id;
  String? typeOfWork;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? walkingTracksCompStatus;
  dynamic date;
  dynamic time;

  WalkingTracksWorkModel({
    this.id,
    this.typeOfWork,
    this.startDate,
    this.expectedCompDate,
    this.walkingTracksCompStatus,
    this.date,
    this.time
  });

  factory WalkingTracksWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return WalkingTracksWorkModel(
        id: json['id'],
        typeOfWork: json['typeOfWork'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        walkingTracksCompStatus:json['walkingTracksCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'typeOfWork':typeOfWork,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'walkingTracksCompStatus':walkingTracksCompStatus,
      'date':date,
      'time':time,

    };
  }
}
