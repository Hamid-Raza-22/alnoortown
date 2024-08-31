class CompactionWaterBoundModel{
  int? id;
  String? blockNo;
  String? roadNo;
  String? totalLength;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? waterBoundCompStatus;
  dynamic date;
  dynamic time;

  CompactionWaterBoundModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.waterBoundCompStatus,
    this.date,
    this.time
  });

  factory CompactionWaterBoundModel.fromMap(Map<dynamic,dynamic>json)
  {
    return CompactionWaterBoundModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        totalLength: json['totalLength'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        waterBoundCompStatus:json['waterBoundCompStatus'],
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
      'waterBoundCompStatus':waterBoundCompStatus,
      'date':date,
      'time':time,
    };
  }
}
