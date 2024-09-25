class MudFillingWorkModel {
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? totalDumpers;
  String? mudFillingCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MudFillingWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.totalDumpers,
    this.mudFillingCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MudFillingWorkModel.fromMap(Map<dynamic, dynamic> json) {
    return MudFillingWorkModel(
      id: json['id'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
      totalDumpers: json['totalDumpers'],
      mudFillingCompStatus: json['mudFillingCompStatus'],
        date:  json['mud_filling_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'totalDumpers': totalDumpers,
      'mudFillingCompStatus': mudFillingCompStatus,
      'mud_filling_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
