class MiniParkCurbStoneModel{
  int? id;
  DateTime? startDate;
  DateTime? expectedCompDate;
  String? mpCurbStoneCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MiniParkCurbStoneModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mpCurbStoneCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MiniParkCurbStoneModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MiniParkCurbStoneModel(
        id: json['id'],
        startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expectedCompDate: json['expectedCompDate'] != null ? DateTime.parse(json['expectedCompDate']) : null,
        mpCurbStoneCompStatus:json['mpCurbStoneCompStatus'],
        date:  json['mini_park_curbStone_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate': startDate?.toString(),
      'expectedCompDate': expectedCompDate?.toString(),
      'mpCurbStoneCompStatus':mpCurbStoneCompStatus,
      'mini_park_curbStone_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
