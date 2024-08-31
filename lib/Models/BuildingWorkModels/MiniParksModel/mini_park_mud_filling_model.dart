class MiniParkMudFillingModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? totalDumpers;
  String? mpMudFillingCompStatus;
  dynamic date;
  dynamic time;

  MiniParkMudFillingModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.totalDumpers,
    this.mpMudFillingCompStatus,
    this.date,
    this.time
  });

  factory MiniParkMudFillingModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MiniParkMudFillingModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        totalDumpers: json['totalDumpers'],
        mpMudFillingCompStatus:json['mpMudFillingCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'totalDumpers':totalDumpers,
      'mpMudFillingCompStatus':mpMudFillingCompStatus,
      'date':date,
      'time':time,

    };
  }
}
