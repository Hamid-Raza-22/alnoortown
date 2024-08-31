class SandCompactionModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic totalLength;
  DateTime? startDate;
  DateTime? expectedCompDate;
  dynamic sandCompStatus;
  dynamic date;
  dynamic time;

  SandCompactionModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.sandCompStatus,
    this.date,
    this.time
  });

  factory SandCompactionModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SandCompactionModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        totalLength: json['totalLength'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        sandCompStatus:json['sandCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'roadNo':roadNo,
      'totalLength':totalLength,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'sandCompStatus':sandCompStatus,
      'date':date,
      'time':time,
    };
  }
}
