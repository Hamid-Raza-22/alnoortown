class SandCompactionModel{
  int? id;
  dynamic block_no;
  dynamic roadNo;
  dynamic totalLength;
  DateTime? startDate;
  DateTime? expectedCompDate;
  dynamic sandCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  SandCompactionModel({
    this.id,
    this.block_no,
    this.roadNo,
    this.totalLength,
    this.startDate,
    this.expectedCompDate,
    this.sandCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory SandCompactionModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SandCompactionModel(
        id: json['id'],
        block_no: json['block_no'],
        roadNo: json['roadNo'],
        totalLength: json['totalLength'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        sandCompStatus:json['sandCompStatus'],
        date:  json['sand_compaction_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'roadNo':roadNo,
      'totalLength':totalLength,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'sandCompStatus':sandCompStatus,
      'sand_compaction_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
