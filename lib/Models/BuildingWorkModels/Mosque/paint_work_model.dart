class PaintWorkModel{
  int? id;
  dynamic  blockNo;
  dynamic  paintWorkStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  PaintWorkModel({
    this.id,
    this.blockNo,
    this.paintWorkStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory PaintWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PaintWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        paintWorkStatus: json['paintWorkStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'paintWorkStatus':paintWorkStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
