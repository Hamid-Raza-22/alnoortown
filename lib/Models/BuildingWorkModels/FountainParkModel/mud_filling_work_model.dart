class MudFillingWorkModel {
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? totalDumpers;
  String? mudFillingCompStatus;
  dynamic date;
  dynamic time;

  MudFillingWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.totalDumpers,
    this.mudFillingCompStatus,
    this.date,
    this.time
  });

  factory MudFillingWorkModel.fromMap(Map<dynamic, dynamic> json) {
    return MudFillingWorkModel(
      id: json['id'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
      totalDumpers: json['totalDumpers'],
      mudFillingCompStatus: json['mudFillingCompStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'totalDumpers': totalDumpers,
      'mudFillingCompStatus': mudFillingCompStatus,
      'date':date,
      'time':time,
    };
  }
}
