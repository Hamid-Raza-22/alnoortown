class MpFancyLightPolesModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? mpLCompStatus;
  dynamic date;
  dynamic time;

  MpFancyLightPolesModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mpLCompStatus,
    this.date,
    this.time
  });

  factory MpFancyLightPolesModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MpFancyLightPolesModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        mpLCompStatus:json['mpLCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'mpLCompStatus':mpLCompStatus,
      'date':date,
      'time':time,

    };
  }
}
