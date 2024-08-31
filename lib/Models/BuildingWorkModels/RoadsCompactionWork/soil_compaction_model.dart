class SoilCompactionModel{
  int? id;
  String? blockNo;
  String? roadNo;
  String?  totalLength;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String?  soilCompStatus;
  dynamic date;
  dynamic time;

  SoilCompactionModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.soilCompStatus,
    this.date,
    this.time
  });

  factory SoilCompactionModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SoilCompactionModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        totalLength: json['totalLength'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        soilCompStatus:json['soilCompStatus'],
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
      'soilCompStatus':soilCompStatus,
      'date':date,
      'time':time,

    };
  }
}
