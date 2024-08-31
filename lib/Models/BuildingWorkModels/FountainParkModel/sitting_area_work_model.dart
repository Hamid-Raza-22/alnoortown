class SittingAreaWorkModel{
  int? id;
  String?  typeOfWork;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? sittingAreaCompStatus;
  dynamic date;
  dynamic time;

  SittingAreaWorkModel({
    this.id,
    this.typeOfWork,
    this.startDate,
    this.expectedCompDate,
    this.sittingAreaCompStatus,
    this.date,
    this.time
  });

  factory SittingAreaWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SittingAreaWorkModel(
        id: json['id'],
        typeOfWork: json['typeOfWork'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        sittingAreaCompStatus:json['sittingAreaCompStatus'],
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
      'sittingAreaCompStatus':sittingAreaCompStatus,
      'date':date,
      'time':time,

    };
  }
}
