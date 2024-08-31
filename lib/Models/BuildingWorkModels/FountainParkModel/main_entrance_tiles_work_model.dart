class MainEntranceTilesWorkModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String?  mainEntranceTilesWorkCompStatus;
  dynamic date;
  dynamic time;

  MainEntranceTilesWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mainEntranceTilesWorkCompStatus,
    this.date,
    this.time
  });

  factory MainEntranceTilesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainEntranceTilesWorkModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        mainEntranceTilesWorkCompStatus:json['mainEntranceTilesWorkCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'mainEntranceTilesWorkCompStatus':mainEntranceTilesWorkCompStatus,
      'date':date,
      'time':time,


    };
  }
}
