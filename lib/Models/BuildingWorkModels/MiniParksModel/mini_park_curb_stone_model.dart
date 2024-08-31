class MiniParkCurbStoneModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? mpCurbStoneCompStatus;
  dynamic date;
  dynamic time;

  MiniParkCurbStoneModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mpCurbStoneCompStatus,
    this.date,
    this.time
  });

  factory MiniParkCurbStoneModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MiniParkCurbStoneModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        mpCurbStoneCompStatus:json['mpCurbStoneCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'mpCurbStoneCompStatus':mpCurbStoneCompStatus,
      'date':date,
      'time':time,

    };
  }
}
