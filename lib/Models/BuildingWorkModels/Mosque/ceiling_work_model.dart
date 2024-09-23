class CeilingWorkModel{
  int? id;
  dynamic block_no;
  dynamic ceilingWorkStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  CeilingWorkModel({
    this.id,
    this.block_no,
    this.ceilingWorkStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory CeilingWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return CeilingWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        ceilingWorkStatus: json['ceilingWorkStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'ceilingWorkStatus':ceilingWorkStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
